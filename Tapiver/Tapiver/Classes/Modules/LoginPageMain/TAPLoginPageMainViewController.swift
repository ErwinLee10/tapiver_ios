//
//  TAPLoginPageMainViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/28/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD

class TAPLoginPageMainViewController: UIViewController {
    
    @IBOutlet weak var triangularView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionLogin(_ sender: UIButton) {
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        let params = NSMutableDictionary()
        guard let email = emailTF.text else {
            return
        }
        guard let password = passwordTF.text else {
            return
        }
        
        if email.isEmpty || password.isEmpty {
            TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Please input all fields", positive: "OK", positiveHandler: nil, vc: self)
            return
        }
        
        if !TAPUtils.shareInstance.isValidEmail(email: email) {
            TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Email not avalid", positive: "OK", positiveHandler: nil, vc: self)
            return
        }
        

        if password.count < 8 {
            TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Password must be of minimum 8 characters length and contain at least 1 number and 1 alphabet", positive: "OK", positiveHandler: nil, vc: self)
            return
        }
        params.setValue(email, forKey: "email")
        params.setValue(password, forKey: "password")
        
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendPOSTRequest(path: API_PATH(path: "/api/v1/auth/u/login-email"), params: params, headers: header, responseObjectClass: TAPLoginModel()) { (success, response) in
            if success {
                let loginModel = response as? TAPLoginModel
                TAPMainFrame.showMainTabbarPage()
            } else {
                 TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Login Failed", positive: "OK", positiveHandler: nil, vc: self)
            }
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func actionForgotpass(_ sender: UIButton) {
         TAPMainFrame.showForgotPage()
    }
    
    @IBAction func actionSkip(_ sender: UIButton) {
        TAPMainFrame.showMainTabbarPage()
    }
    
    @IBAction func actionSignup(_ sender: UIButton) {
        TAPMainFrame.showSignupEmailPage()
    }
}
