//
//  TAPMallPageDealsCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/12/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SDWebImage

class TAPMallPageDealsCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
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
        setupView()
    }
    
    func fillData(product: TAPProductModel) {
        let imageURL = URL.init(string: product.sellerPicture ?? "")
        productImgView.sd_setImage(with: imageURL, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
        typeLabel.text = product.brand?.uppercased()
        nameLabel.text = product.name
        
        let variations = product.variationsOverview
        if let originPrice = variations?.originalPrice, originPrice > 0 {
            let stdOriginPrice = NSNumber(value: originPrice).moneyString()
            let priceAttStr = NSMutableAttributedString(string: stdOriginPrice)
            priceAttStr.addAttributes([NSAttributedStringKey.strikethroughStyle: 1], range: NSMakeRange(0, priceAttStr.length))
            originPriceLabel.attributedText = priceAttStr
        } else {
            originPriceLabel.text = ""
        }
        
        let stdSalePrice = NSNumber(value: variations?.salePrice ?? 0).moneyString()
        realPriceLabel.text = stdSalePrice
        numOfLikesLabel.text = "\(product.likes)"
    }

    @IBAction func likeBtnTouched(_ sender: Any) {
    }
    
    private func setupView() {
        containerView.layer.masksToBounds = true
    }
}
