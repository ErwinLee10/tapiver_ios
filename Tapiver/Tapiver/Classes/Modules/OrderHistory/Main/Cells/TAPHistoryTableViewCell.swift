//
//  TAPHistoryTableViewCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SDWebImage

class TAPHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(orderItem: TAPOrderItemModel) {
        let imageURL = URL.init(string: orderItem.itemPictures.first ?? "")
        avatarImgView.sd_setImage(with: imageURL, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
        
        brandLabel.text = ""
        nameLabel.text = orderItem.itemName
        
        var des = ""
        let color = orderItem.colorName ?? ""
        let size = orderItem.size != nil ? "\(orderItem.size!)" : ""
        if color.isEmpty == false, size.isEmpty == false {
            des = "\(color)-\(size)"
        } else {
            des = "\(color)\(size)"
        }
        descriptionLabel.text = des
        
        priceLabel.text = "\(orderItem.finalPrice ?? 0)"
        quantityLabel.text = "\(orderItem.quantity ?? 0)"
    }
    
}
