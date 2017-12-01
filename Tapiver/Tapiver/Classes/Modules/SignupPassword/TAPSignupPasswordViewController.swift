//
//  TAPSignupPasswordViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPSignupPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actionSignup(_ sender: UIButton) {
        TAPMainFrame.showMainTabbarPage()
    }
    
    @IBAction func actionSigupFacebook(_ sender: UIButton) {
    }
    
    @IBAction func actionLoginc(_ sender: UIButton) {
        
         TAPMainFrame.showLoginPageMain()
    }
    
}
