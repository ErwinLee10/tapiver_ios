//
//  TAPIntroPageViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/28/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPIntroPageViewController: UIViewController {

    @IBOutlet weak var backgroundIV: UIImageView!
    var gIndex:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch gIndex {
        case 0:
            backgroundIV.image = UIImage.init(named: "splash")
        case 1:
            backgroundIV.image = UIImage.init(named: "splash01")
        case 2:
            backgroundIV.image = UIImage.init(named: "splash02")
        case 3:
            backgroundIV.image = UIImage.init(named: "splash03")
        default:
            break
        }
    }
    
}
