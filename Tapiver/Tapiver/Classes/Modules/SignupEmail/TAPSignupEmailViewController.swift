//
//  TAPSignupEmailViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
//import SVProgressHUD
import FBSDKLoginKit

class TAPSignupEmailViewController: UIViewController {
    
    var email: String! = ""
    var firstName: String?
    var lastName: String?

    @IBOutlet weak var triangularView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
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
        
        self.emailTF.text = email
        self.firstNameTF.text = firstName
        self.lastNameTF.text = lastName
    }

    @IBAction func actionSignupNext(_ sender: UIButton) {
        guard let email = emailTF.text
            else {
            return
        }
        
        if email.isEmpty {
            TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Please input all fields", positive: "OK", positiveHandler: nil, vc: self)
            return
        }
        
        if !TAPUtils.shareInstance.isValidEmail(email: email) {
            TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Email not avalid", positive: "OK", positiveHandler: nil, vc: self)
            return
        }
        
        TAPMainFrame.showSignupPassPage(email:email, firstName: firstNameTF.text, lastName: lastNameTF.text)
    }
    @IBAction func actionSignupFacebook(_ sender: Any) {
        
    }
    
    @IBAction func actionLogin(_ sender: UIButton) {
        TAPMainFrame.showLoginPageMain()
    }
    
    @IBAction func actionFacebook(_ sender: UIButton) {
        self.pLoginWithFacebook()
    }
    
}

extension TAPSignupEmailViewController {
    
    // MARK: Facebook
    
    func pLoginWithFacebook() -> Void {
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        let facebookReadPermissions = ["public_profile", "email", "user_friends"]
        if FBSDKAccessToken.current() != nil {
            return
        }
        
        fbLoginManager.logIn(withReadPermissions: facebookReadPermissions, from: self) { (result, error) in
            if let error = error {
                print("error->\(error)")
                FBSDKLoginManager().logOut()
            } else if (result?.isCancelled)! {
                FBSDKLoginManager().logOut()
            } else {
                self.fetchFacebookUserInfo()
                
            }
        }
    }
    
    func fetchFacebookUserInfo ()-> Void
    {
        if (FBSDKAccessToken.current() != nil)
        {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, link, first_name, last_name, email, birthday, location ,friends ,hometown"])
            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                
                if let error = error {
                    print("Error: \(error)")
                } else {
                    let email = (result as! NSDictionary).value(forKey: "email") as? String ?? ""
                    let firstName = (result as! NSDictionary).value(forKey: "first_name") as? String ?? ""
                    let lastName = (result as! NSDictionary).value(forKey: "last_name") as? String ?? ""
                    self.loginWithFacebook(token: FBSDKAccessToken.current().tokenString, email: email, firstName: firstName, lastName: lastName)
                }
            })
        }
    }
    
    func loginWithFacebook(token: String, email: String?, firstName: String?, lastName: String?) -> Void {
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        let params = NSMutableDictionary()
        params.setValue(token, forKey: "token")
        //SVProgressHUD.show()
        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendPOSTRequest(path: API_PATH(path: "/api/v1/auth/u/continue-with-facebook"), params: params, headers: header, responseObjectClass: TAPLoginModel()) { (success, response) in
            if success {
                guard let model = response as? TAPLoginModel else {
                    return
                }
                TAPGlobal.shared.saveLoginModel(model: model)
                TAPGlobal.shared.saveHasLogin(isLogin: true)
                TAPMainFrame.showMainTabbarPage()
            } else {
                TAPMainFrame.showSignupEmailPage(email: email, firstName: firstName, lastName: lastName)
            }
            //SVProgressHUD.dismiss()
            TAPGlobal.shared.dismissLoading()
        }
    }
}
