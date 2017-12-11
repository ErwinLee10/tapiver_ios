//
//  TAPMallPageDealsCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/12/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPMallPageDealsCell: UICollectionViewCell {
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originPriceLabel: UILabel!
    @IBOutlet weak var realPriceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var numOfLikesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    @IBAction func likeBtnTouched(_ sender: Any) {
    }
}
