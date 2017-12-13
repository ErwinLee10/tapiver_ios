//
//  TAPBaseViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/11/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPBaseViewController: UIViewController {
    @IBOutlet weak var headerView: TAPHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(netHex: 0xDEDEDE)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
