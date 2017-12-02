//
//  TAPSignupEmailViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPSignupEmailViewController: UIViewController {
    
    var email: String!

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
    
}
