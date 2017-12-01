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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actionSignupNext(_ sender: UIButton) {
        TAPMainFrame.showSignupPassPage()
    }
    @IBAction func actionSignupFacebook(_ sender: Any) {
        
    }
    
    @IBAction func actionLogin(_ sender: UIButton) {
        TAPMainFrame.showLoginPageMain()
    }
    
}
