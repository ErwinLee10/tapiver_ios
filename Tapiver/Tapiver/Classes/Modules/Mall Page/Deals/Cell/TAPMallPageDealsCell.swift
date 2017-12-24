//
//  TAPMallPageDealsCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/12/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class TAPMallPageDealsCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originPriceLabel: UILabel!
    @IBOutlet weak var realPriceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var numOfLikesLabel: UILabel!
    
    var productModel: TAPProductModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    func fillData(product: TAPProductModel) {
        productModel = product
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
        
        likeButton.isSelected = product.isLikedByThisUser
    }

    @IBAction func likeBtnTouched(_ sender: Any) {
        if TAPGlobal.shared.hasLogin() {
            if likeButton.isSelected {
                removeLikeProduct()
            } else {
                addLikeProduct()
            }
        } else {
            TAPMainFrame.showLoginPageMain()
        }
    }
    
    private func setupView() {
        containerView.layer.masksToBounds = true
    }
    
    private func addLikeProduct() {
        let apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/like\(productModel?.id ?? "")"
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendPUTRequest(path: apiPath, parameters: [:]) { [weak self] (isSuccess) in
            SVProgressHUD.dismiss()
            if isSuccess {
                self?.updateLikes(isAdd: true)
            }
        }
    }
    
    private func removeLikeProduct() {
        let apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/like/\(productModel?.id ?? "")"
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendDELETERequest(path: apiPath) { [weak self] (isSuccess, responseData) in
            SVProgressHUD.dismiss()
            
            if isSuccess {
                self?.updateLikes(isAdd: false)
            }
        }
    }
    
    private func updateLikes(isAdd: Bool) {
        if isAdd {
            productModel?.isLikedByThisUser = true
            productModel?.likes = (productModel?.likes ?? 0) + 1
            likeButton.isSelected = true
            numOfLikesLabel.text = "\(productModel?.likes ?? 0)"
        } else {
            productModel?.isLikedByThisUser = false
            if let likes = productModel?.likes, likes > 0 {
                productModel?.likes = likes - 1
            }
            likeButton.isSelected = true
            numOfLikesLabel.text = "\(productModel?.likes ?? 0)"
        }
    }
}
