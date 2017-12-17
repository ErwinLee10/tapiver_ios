//
//  TAPCartCouponTableViewCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPCartCouponTableViewCell: UITableViewCell {
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var couponTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func submitTouched(_ sender: Any) {
        
    }
}
