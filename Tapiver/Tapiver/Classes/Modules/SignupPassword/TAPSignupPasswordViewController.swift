//
//  TAPSignupPasswordViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD
import SafariServices

class TAPSignupPasswordViewController: UIViewController {

    var email: String!
    var firstName: String?
    var lastName: String?
    
    @IBOutlet weak var triangularView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let path = UIBezierPath()
        let frame = triangularView.bounds
        path.move(to: CGPoint.init(x: frame.width/2, y: 0))
        path.addLine(to: CGPoint.init(x: 0, y: frame.height))
        path.addLine(to: CGPoint.init(x: frame.width, y: frame.height))
        path.move(to: CGPoint.init(x: frame.width/2, y: 0))
        let mask = CAShapeLayer()
        mask.frame = frame
        mask.path = path.cgPath
        triangularView.layer.mask = mask
    }
    
    @IBAction func actionTerms(_ sender: UIButton) {
        guard let url = URL.init(string: "https://tapiver.com/termsandconditions") else {
            return
        }
        UIApplication.shared.openURL(url)
    }
    
    @IBAction func actionPolicy(_ sender: UIButton) {
        guard let url = URL.init(string: "https://tapiver.com/privacy") else {
            return
        }
        UIApplication.shared.openURL(url)
    }

    @IBAction func actionSignup(_ sender: UIButton) {
        
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        let params = NSMutableDictionary()
        params.setValue(email, forKey: "email")
        params.setValue(firstName ?? "", forKey: "firstName")
        params.setValue(email, forKey: "lastName")
        guard let password = passwordTF.text else {
            return
        }
        guard let confirmPassword = confirmPasswordTF.text else {
            return
        }
        
        if password.isEmpty || confirmPassword.isEmpty {
            TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Please input all fields", positive: "OK", positiveHandler: nil, vc: self)
            return
        }
        
        if (password != confirmPassword) {
            TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Password and confirmation password do not match", positive: "OK", positiveHandler: nil, vc: self)
            return
        }
        
        if password.count < 8 {
            TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Password must be of minimum 8 characters length and contain at least 1 number and 1 alphabet", positive: "OK", positiveHandler: nil, vc: self)
            return
        }
        
        params.setValue(password, forKey: "password")
        
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendPOSTRequest(path: API_PATH(path: "/api/v1/auth/u/register-password"), params: params, headers: header, responseObjectClass: TAPLoginModel()) { (success, response) in
            if success {
                let loginModel = response as? TAPLoginModel
                TAPMainFrame.showMainTabbarPage()
            } else {
                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Sign up failed", positive: "OK", positiveHandler: nil, vc: self)
            }
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func actionSigupFacebook(_ sender: UIButton) {
    }
    
    @IBAction func actionLoginc(_ sender: UIButton) {
        
         TAPMainFrame.showLoginPageMain()
    }
    
}
