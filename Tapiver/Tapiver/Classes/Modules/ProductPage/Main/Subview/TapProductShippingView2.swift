//
//  TapProductShippingView2.swift
//  Tapiver
//
//  Created by admin on 12/21/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation

protocol TapProductShippingView2Delegate {
    func showStorePickUp()
}

class TapProductShippingView2: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cashbackLabel: UILabel!
    
    var delegate: TapProductShippingView2Delegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Insert code here
    }
    
    func setData(name: String, cashback: Int) {
        nameLabel.text = name
        cashbackLabel.text = "Cashback \(cashback)%"
    }
    
    @IBAction func storePickupDetailsButtonTap(_ sender: UIButton) {
        delegate?.showStorePickUp()
    }
}
