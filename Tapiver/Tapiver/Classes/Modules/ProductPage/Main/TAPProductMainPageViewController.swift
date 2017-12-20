//
//  TAPProductMainPageViewController.swift
//  Tapiver
//
//  Created by HungHN on 12/13/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPProductMainPageViewController: UIViewController {

    @IBOutlet weak var imageContainView: UIView!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var colorTableView: UITableView!
    
    @IBOutlet weak var titleStackContainView: UIView!
    @IBOutlet weak var titleStack: UIStackView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var shippingStackContainView: UIView!
    @IBOutlet weak var shippingStack: UIStackView!
    
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyLocationLabel: UILabel!
    @IBOutlet weak var companyFollowerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func likeProductButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func followCompanyButtonTap(_ sender: UIButton) {
    }
    
}
