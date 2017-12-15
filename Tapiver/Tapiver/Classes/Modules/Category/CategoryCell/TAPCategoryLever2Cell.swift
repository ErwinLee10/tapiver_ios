//
//  TAPCategoryLever2Cell.swift
//  Tapiver
//
//  Created by HungVT on 12/15/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
enum TAPCategoryLever2CellType {
    case Category
    case LandMark
}

class TAPCategoryLever2Cell: UITableViewCell {
    @IBOutlet weak var lbNameMenu2: UILabel!
    @IBOutlet weak var lineBreak: UIView!
    var typeLever: TAPCategoryLever2CellType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func setIB() {
        switch self.typeLever! {
        case TAPCategoryLever2CellType.Category:
            print("Category")
        case TAPCategoryLever2CellType.LandMark:
            self.lbNameMenu2.textColor = UIColor.black
            self.lineBreak.isHidden = true
            self.contentView.backgroundColor = UIColor.clear
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
