//
//  TAPHistoryOrderInformationTableViewCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/20/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

protocol TAPHistoryOrderInformationTableViewCellDelegate: class {
    func historyOrderInformationCellDidTouchConfirm(cell: TAPHistoryOrderInformationTableViewCell)
    func historyOrderInformationCellDidTouchReport(cell: TAPHistoryOrderInformationTableViewCell)
    func historyOrderInformationCellDidTouchVisitShop(cell: TAPHistoryOrderInformationTableViewCell)
}

class TAPHistoryOrderInformationTableViewCell: UITableViewCell {
    @IBOutlet weak var fromToLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var moneyValueLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var confirmHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var visitShopHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var reportHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: TAPHistoryOrderInformationTableViewCellDelegate?
    var orderModel: TAPOrderModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        confirmButton.setBackgroundImage(UIImage.imageFromColor(UIColor.init(netHex: 0x1caab6)), for: .normal)
            confirmButton.layer.masksToBounds = true
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(orderData: TAPOrderModel) {
        orderModel = orderData
        addressLabel.text = (orderData.sellerAddress?.formattedAddress ?? "") + "\n" + (orderData.sellerAddress?.contact ?? "")
        moneyValueLabel.text = NSNumber(value: orderData.cashback ?? 0).moneyString()
        totalMoneyLabel.text = NSNumber(value:0).moneyString() // Todo
        
        if orderData.orderStatus != "Ready for Pick up" {
            confirmHeightConstraint.constant = 0
            reportHeightConstraint.constant = 0
        } else {
            confirmHeightConstraint.constant = 45
            reportHeightConstraint.constant = 45
        }
        self.layoutIfNeeded()
    }
    
    @IBAction func confirmTouched(_ sender: Any) {
        delegate?.historyOrderInformationCellDidTouchConfirm(cell: self)
    }
    
    @IBAction func reportTouched(_ sender: Any) {
        delegate?.historyOrderInformationCellDidTouchReport(cell: self)
    }
    
    @IBAction func visitShopTouched(_ sender: Any) {
        delegate?.historyOrderInformationCellDidTouchVisitShop(cell: self)
    }
}
