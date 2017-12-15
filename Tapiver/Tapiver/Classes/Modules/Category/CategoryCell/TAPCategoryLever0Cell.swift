//
//  TAPCategoryLever0Cell.swift
//  Tapiver
//
//  Created by HungVT on 12/14/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPCategoryLever0Cell: UITableViewCell {
    @IBOutlet weak var imvMenu: UIImageView!
    @IBOutlet weak var lbNameMenu: UILabel!
    public var indexMenu0: NSIndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    public func setDataMenu0(object: TAPCategoryMenuEntity){
        self.lbNameMenu.text = object.name
        var corlor: UIColor?
        if object.isSelected == true {
            self.imvMenu.image = object.imgSelected
             corlor = UIColor.black
        }else{
            self.imvMenu.image = object.imgNormal
            corlor = UIColor.init(netHex: 0x848585)
        }
        self.lbNameMenu.textColor = corlor!
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
