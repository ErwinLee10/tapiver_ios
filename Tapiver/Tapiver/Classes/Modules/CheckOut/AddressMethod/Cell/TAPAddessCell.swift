//
//  TAPAddessCell.swift
//  Tapiver
//
//  Created by Hung vu on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
@objc protocol TAPAddessCellDelegate: class {
    @objc func acSelectAddAt(index: IndexPath, withObj:TAPAddressModel)
}
class TAPAddessCell: UITableViewCell {

    @IBOutlet weak var btSelectAdd: UIButton!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbContact: UILabel!
    public weak var delegate: TAPAddessCellDelegate?
    public var index: IndexPath?
    public var obj: TAPAddressModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setData() {
        self.lbContact.text = self.obj?.contact
        self.lbContent.text = self.obj?.streetName
    }
    @IBAction func adSelectAdd(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if self.delegate != nil {
            self.delegate?.acSelectAddAt(index: self.index!, withObj: self.obj!)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
