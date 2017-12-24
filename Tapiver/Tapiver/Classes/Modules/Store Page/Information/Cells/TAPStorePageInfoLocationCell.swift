//
//  TAPStorePageInfoLocationCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/17/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPStorePageInfoLocationCell: UITableViewCell {
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var normalTimeLabel: UILabel!
    @IBOutlet weak var weekenTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addressLabel.text = "addressLabel addressLabel addressLabel addressLabel addressLabel addressLabel"
        normalTimeLabel.text = "addressLabel addressLabel"
        weekenTimeLabel.text = "addressLabel addressLabel addressLabel addressLabel addressLabel addressLabel addressLabel addressLabel addressLabel"
    }
    
    func setContent(index: Int, address: TAPAddressModel?) -> Void {
        guard let add = address else {
            addressLabel.text = ""
            normalTimeLabel.text = ""
            weekenTimeLabel.text = ""
            return
        }
        indexLabel.text = "\(index + 1)"
        var addressStr = "\(address?.buildingName ?? "")"
        if let floorAndUnit = add.formattedFloorAndUnitAddres, floorAndUnit.isEmpty == false {
            addressStr += " \(floorAndUnit)"
        }
        if let street = add.streetName, street.isEmpty == false {
            addressStr += "\n\(street)"
        }
        addressLabel.text = addressStr
        normalTimeLabel.text = "" // TODO: later
        weekenTimeLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
