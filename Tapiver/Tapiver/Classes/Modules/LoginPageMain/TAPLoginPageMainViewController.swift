//
//  TAPLoginPageMainViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/28/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPLoginPageMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionLogin(_ sender: UIButton) {
        TAPMainFrame.showMainTabbarPage()
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
