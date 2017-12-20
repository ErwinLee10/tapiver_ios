//
//  TAPSubShippingMethod.swift
//  Tapiver
//
//  Created by HungVT on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
@objc protocol TAPSubShippingMethodDelegate: class {
    @objc func selectAtIndex(index: IndexPath, obj:TAPSubShippingEntity)
}

class TAPSubShippingMethod: UITableViewCell {

    @IBOutlet weak var btCheckBox: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbNumber: UILabel!
    public var index: IndexPath?
    public var obj: TAPSubShippingEntity?
    public weak var delegate: TAPSubShippingMethodDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func setData() {
        self.btCheckBox.isSelected = (self.obj?.isSelect)!
        self.lbTitle.text = self.obj?.titleSub
        self.lbNumber.text = self.obj?.cost
    }
    
    @IBAction func acSelect(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if self.delegate != nil {
            self.delegate?.selectAtIndex(index: self.index!, obj: self.obj!)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
