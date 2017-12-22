//
//  TapProductShippingView1.swift
//  Tapiver
//
//  Created by admin on 12/21/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TapProductShippingView1: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Insert code here
    }
    
    func setData(name: String, day: String, price: Int) {
        nameLabel.text = name
        dayLabel.text = day
        priceLabel.text = "S$ \(price)"
    }
}
