//
//  TAPHeaderAddTableViewCell.swift
//  Tapiver
//
//  Created by Hung vu on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
@objc protocol TAPHeaderAddCellDelegate : class {
    func tapSelectSameasShipping(isSelect: Bool)
}


class TAPHeaderAddTableViewCell: UITableViewCell {
    @IBOutlet weak var lbHeade: UILabel!
    @IBOutlet weak var btCheckBox: UIButton!
    @IBOutlet weak var lbSelectSameAs: UILabel!
    public var isHeaderCheckBox: Bool?
    public weak var delegate: TAPHeaderAddCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    public func setData() {
        btCheckBox.isHidden  =  isHeaderCheckBox!
        lbSelectSameAs.isHidden =  isHeaderCheckBox!
        if isHeaderCheckBox == true {
            lbHeade.text = "Shipping Address"
        }else {
            lbHeade.text = "Billing Address"
        }
    }
    // MARK : IBAction
    
    @IBAction func acCheckBox(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if self.delegate != nil {
            self.delegate?.tapSelectSameasShipping(isSelect: sender.isSelected)
        }
    }
    
    @IBOutlet weak var acSelectSameAS: UIButton!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
