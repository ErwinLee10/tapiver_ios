//
//  TAPLostConnectErrorView.swift
//  Tapiver
//
//  Created by admin on 12/23/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPLostConnectErrorView: UIView {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.text = "You are not connected to the internet. Please enable mobile data or wifi."
    }
}
