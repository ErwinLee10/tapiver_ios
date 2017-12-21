//
//  TAPHistoryOrderInformationTableViewCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/20/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

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
    @IBAction func confirmTouched(_ sender: Any) {
    }
    
    @IBAction func reportTouched(_ sender: Any) {
    }
    
    @IBAction func visitShopTouched(_ sender: Any) {
    }
}
