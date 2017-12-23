//
//  TAPGeneralErrorView.swift
//  Tapiver
//
//  Created by admin on 12/23/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPGeneralErrorView: UIView {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.text = "Tapiver encountered an issue. We will be back as really soon!"
    }
}
