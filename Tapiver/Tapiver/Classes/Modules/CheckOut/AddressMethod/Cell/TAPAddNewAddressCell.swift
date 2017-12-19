//
//  TAPAddNewAddressCell.swift
//  Tapiver
//
//  Created by HungVT on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
@objc protocol TAPAddNewAddressCellDelegate: class {
    func tapAddNewAddAt(index: IndexPath, isAddShipping:Bool)
    
}
class TAPAddNewAddressCell: UITableViewCell {
    public var isAdressShipping: Bool = false
    public var index: IndexPath?
    public weak var delegate: TAPAddNewAddressCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func acAddNew(_ sender: Any) {
        if self.delegate != nil {
            self.delegate?.tapAddNewAddAt(index: self.index!, isAddShipping: isAdressShipping)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
