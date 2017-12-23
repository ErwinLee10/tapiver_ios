//
//  TAPAddessCell.swift
//  Tapiver
//
//  Created by Hung vu on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
@objc protocol TAPAddessCellDelegate: class {
    @objc func acSelectAddAt(index: IndexPath, withObj:TAPChecOutEntity)
}
class TAPAddessCell: UITableViewCell {

    @IBOutlet weak var btSelectAdd: UIButton!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbContact: UILabel!
    public weak var delegate: TAPAddessCellDelegate?
    public var index: IndexPath?
    public var obj: TAPChecOutEntity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setData() {
        let checkOut = obj!.addObj
        self.lbContact.text = checkOut!.contact
        self.lbContent.text = createContetn(obj: checkOut!)
        self.btSelectAdd.isSelected = obj!.isSelected
    }
    private func createContetn(obj: TAPAddressModel) -> String? {
        var content: String = ""
        if let street = obj.streetName {
            content.append("\(street)")
        }
        if let floor = obj.floor {
            var str = ""
            if let unitNumber = obj.unitNumber {
                 str = ("-\(unitNumber)")
            }
            content.append("\n#\(floor)" + str)
        }else {
            if let unitNumber = obj.unitNumber {
                content.append("\n-\(unitNumber)")
            }
        }
        
        if let postalCode = obj.postalCode {
            content.append("\n\(postalCode)")
        }
        
        return content
    }
    @IBAction func adSelectAdd(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if self.delegate != nil {
            self.obj?.isSelected = sender.isSelected
            self.delegate?.acSelectAddAt(index: self.index!, withObj: self.obj!)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
