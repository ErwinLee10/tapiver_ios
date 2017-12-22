//
//  TAPHistoryReportIssueViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/23/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPHistoryReportIssueViewController: TAPBaseViewController {
    @IBOutlet weak var issueArrowButton: UIButton!
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var shopAddressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func issuesSelect(_ sender: Any) {
        let issueActionSheeet = UIAlertController(title: "Raise issues", message: "", preferredStyle: .actionSheet)
        issueActionSheeet.addAction(title: "I did not receive the product(s)", style: .default) { [weak self] (alertAction) in
            self?.issueTitleLabel.text = alertAction.title
        }
        issueActionSheeet.addAction(title: "I received the wrong product(s) – Wrong size/colour/ different products", style: .default) { [weak self] (alertAction) in
            self?.issueTitleLabel.text = alertAction.title
        }
        issueActionSheeet.addAction(title: "I received damaged/ faulty product(s)", style: .default) { [weak self] (alertAction) in
            self?.issueTitleLabel.text = alertAction.title
        }
        issueActionSheeet.addAction(title: "Cancel", style: .cancel) { (alertAction) in
            
        }
        self.present(issueActionSheeet, animated: true, completion: nil)
    }
    
    @IBAction func policyTouched(_ sender: Any) {
        if let link = URL(string: "https://tapiver.com/faq") {
            UIApplication.shared.openURL(link)
        }
    }

    @IBAction func submitBtnTouched(_ sender: Any) {
    }
}
