//
//  TAPForgotPasswordViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
//import SVProgressHUD

class TAPForgotPasswordViewController: UIViewController {

    @IBOutlet weak var triangularView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    
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

    @IBAction func actionForgot(_ sender: UIButton) {
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        guard let email = emailTF.text else {
            return
        }
        
        if !TAPUtils.shareInstance.isValidEmail(email: email) {
            TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Email not avalid", positive: "OK", positiveHandler: nil, vc: self)
            return
        }
        
        let apiPath = API_PATH(path: "/api/v1/auth/forgot-password/") + email
        //SVProgressHUD.show()
        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendPOSTRequest(path: apiPath, params: NSDictionary(), headers: header, responseObjectClass: TAPLoginModel()) { (success, response) in
            if success {
                guard let model = response as? TAPLoginModel else {
                    TAPGlobal.shared.dismissLoading()
                    return
                }
                TAPGlobal.shared.saveLoginModel(model: model)
                TAPGlobal.shared.saveHasLogin(isLogin: true)
                TAPMainFrame.showLoginPageMain()
            } else {
                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
            }
            //SVProgressHUD.dismiss()
            TAPGlobal.shared.dismissLoading()
        }
    }
    
}
