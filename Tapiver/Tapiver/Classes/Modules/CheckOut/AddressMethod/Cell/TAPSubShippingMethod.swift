//
//  TAPSubShippingMethod.swift
//  Tapiver
//
//  Created by HungVT on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
@objc protocol TAPSubShippingMethodDelegate: class {
    @objc func selectAtIndex(index: IndexPath, obj:TAPShippingModel, isSelect: Bool)
}

class TAPSubShippingMethod: UITableViewCell {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lbHeader: UILabel!
    @IBOutlet weak var lbCashBack: UILabel!
    @IBOutlet weak var btCheckBox: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbNumber: UILabel!
    public var index: IndexPath?
    public var obj: TAPShippingModel?
    public weak var delegate: TAPSubShippingMethodDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func setData() {
        self.btCheckBox.isSelected = self.obj!.isSelect
        self.lbTitle.text = "\(obj!.provider ?? "") \(obj!.type ?? "")"
        if obj?.isfreeShipping == true {
            self.lbNumber.text = "Free"
        }else {
            self.lbNumber.text = "S$ \(obj!.price ?? 0.00)"
        }
        self.lbCashBack.isHidden = true
        if let cashBack = obj!.additionalInfor?.cashbackPercentage {
            if cashBack > 0.1 {
                self.lbCashBack.isHidden = false
            }else {
                self.lbCashBack.isHidden = true
            }
            self.lbCashBack.text  = "Cashback \(cashBack)%"
        }
    }
    
    @IBAction func acSelect(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.obj!.isSelect = sender.isSelected
        if self.delegate != nil {
            self.delegate?.selectAtIndex(index: self.index!, obj: self.obj!, isSelect: sender.isSelected)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
