//
//  TAPHistoryReportIssueViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/23/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD

class TAPHistoryReportIssueViewController: TAPBaseViewController {
    @IBOutlet weak var issueArrowButton: UIButton!
    @IBOutlet weak var issueTitleLabel: UILabel!
    @IBOutlet weak var shopAddressLabel: UILabel!
    
    var orderId: String!
    var sellerAddress: TAPSellerAddressModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let header = headerView as? TAPHeaderView {
            header.hideCartButton(true)
            header.hideMenuButton(true)
            header.hideSearchButton(true)
            header.setHeaderTitle("Report Issue")
        }
        issueTitleLabel.text = ""
        shopAddressLabel.text = "\(sellerAddress?.formattedAddress ?? "")\n\(sellerAddress?.contact ?? "")"
    }
    
    @IBAction func issuesSelect(_ sender: Any) {
        let issueActionSheeet = UIAlertController(title: "Raise issues", message: nil, preferredStyle: .actionSheet)
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
        UILabel.appearance(whenContainedInInstancesOf: [UIAlertController.self]).numberOfLines = 2
        self.present(issueActionSheeet, animated: true, completion: nil)
    }
    
    @IBAction func policyTouched(_ sender: Any) {
        if let link = URL(string: "https://tapiver.com/faq") {
            UIApplication.shared.openURL(link)
        }
    }

    @IBAction func submitBtnTouched(_ sender: Any) {
        submitReport()
    }
    
    // MARK: Private
    private func submitReport() {
        let params: [String: Any] = [TAPConstants.APIParams.message: issueTitleLabel.text ?? ""]
        let stdOrderId = orderId ?? ""
        let apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/orders/\(stdOrderId)/report"
        
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendPOSTRequest(path: apiPath, params: params, responseObjectClass: TAPBaseEntity()) { [weak self] (success, responseEntity) in
            
            SVProgressHUD.dismiss()
            self?.showSubmitResultMessage(isSuccess: success)
        }
    }
    
    private func showSubmitResultMessage(isSuccess: Bool) {
        let msg = isSuccess ? "We really appreciate your feedback!" : "Failed. Please try again and if persists, contact Tapiver team."
        UIAlertController.showAlert(in: self, withTitle: "", message: msg, cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: nil)
    }
}
