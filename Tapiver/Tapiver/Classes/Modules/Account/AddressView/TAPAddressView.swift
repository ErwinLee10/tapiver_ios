//
//  TAPAddressView.swift
//  Tapiver
//
//  Created by admin on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation

protocol TAPAddressViewDelegate {
    func deleteAddress(id: Int?)
}

class TAPAddressView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var floor_unitLabel: UILabel!
    @IBOutlet weak var postalLabel: UILabel!
    
    @IBOutlet weak var stackLabelView: UIStackView!
    
    var id: Int!
    
    var delegate: TAPAddressViewDelegate?
    
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Insert code here
    }
    
    func setData(name: String, contactNumber: String, street: String, floor: String?, unit: String?, postal: String) {
        nameLabel.text = name
        contactLabel.text = contactNumber
        streetLabel.text = street
        if floor == nil || unit == nil || floor == "" || unit == "" {
            stackLabelView.removeArrangedSubview(floor_unitLabel)
            floor_unitLabel.isHidden = true
        }
        else {
            floor_unitLabel.text = "#" + floor! + "-" + unit!
        }
        postalLabel.text = postal
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
    }
    @IBAction func deleteButtonTap(_ sender: UIButton) {
        TAPWebservice.shareInstance.sendDELETERequest(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/address/\(String(id))") { (check) in
            if check {
                self.delegate?.deleteAddress(id: self.id)
            }
            else {
                self.delegate?.deleteAddress(id: nil)
            }
        }
    }
}
