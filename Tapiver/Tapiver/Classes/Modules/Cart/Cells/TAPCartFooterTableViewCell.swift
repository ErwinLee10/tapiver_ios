//
//  TAPCartFooterTableViewCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPCartFooterTableViewCell: UITableViewCell {
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTotalPrice(_ price: Int) {
        let priceStr = NSNumber(value: price).moneyString()
        totalPriceLabel.text = priceStr
    }
    
}
