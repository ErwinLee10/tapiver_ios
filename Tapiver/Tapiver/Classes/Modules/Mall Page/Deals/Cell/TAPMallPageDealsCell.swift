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
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var widthCollection: NSLayoutConstraint!
    
    var productModel: TAPProductModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    func fillData(product: TAPProductModel) {
        productModel = product
        setListColor(count: product.variationsOverview!.listColor.count)
        var index = 0
        
        for i in 0..<(product.variationsOverview?.listVariations?.count)! {
            if product.variationsOverview?.listVariations![i].salePrice != nil {
                index = i
            }
        }
        let imageURL = URL.init(string: product.variationsOverview?.listVariations![index].pictures![0] ?? "")
        productImgView.sd_setImage(with: imageURL, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
        typeLabel.text = product.brand?.uppercased()
        nameLabel.text = product.name
        
        let variations = product.variationsOverview?.listVariations![0]
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
    private func setListColor(count: Int) {
        if count > 1 && count <= 4 {
            viewColor.isHidden = false
            let cellWidth = 16
            let spaceBetweenCell = 6
            widthCollection.constant = CGFloat(count * cellWidth + (count - 1) * spaceBetweenCell)
        }else {
            viewColor.isHidden = true
            widthCollection.constant = 0;
        }
        collectionview.reloadData()
    }
    func setColor(idxColor: Int){
        
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
        collectionview.register(UINib(nibName: "TAPFeedColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TAPFeedColorCollectionViewCell")
        collectionview.delegate = self
        collectionview.dataSource = self
    }
    
    private func addLikeProduct() {
        let apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/like/\(productModel?.id ?? "")"
        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendPUTRequest(path: apiPath, parameters: [:]) { [weak self] (isSuccess) in
            TAPGlobal.shared.dismissLoading()
            if isSuccess {
                self?.updateLikes(isAdd: true)
            } else {
                if let rootVC = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController {
                    TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: rootVC)
                }
            }
        }
    }
    
    private func removeLikeProduct() {
        let apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/like/\(productModel?.id ?? "")"
        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendDELETERequest(path: apiPath) { [weak self] (isSuccess, responseData) in
            TAPGlobal.shared.dismissLoading()
            
            if isSuccess {
                self?.updateLikes(isAdd: false)
            } else {
                if let rootVC = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController {
                    TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: rootVC)
                }
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
            likeButton.isSelected = false
            numOfLikesLabel.text = "\(productModel?.likes ?? 0)"
        }
    }
}
extension TAPMallPageDealsCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageURL = URL.init(string: productModel?.variationsOverview?.listVariations![indexPath.item].pictures![0] ?? "")
        productImgView.sd_setImage(with: imageURL, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
    }
}

extension TAPMallPageDealsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = productModel?.variationsOverview?.listColor.count
        if count! < 2 {
            return 0;
        }
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TAPFeedColorCollectionViewCell", for: indexPath) as! TAPFeedColorCollectionViewCell
        cell.colorView.layer.cornerRadius = cell.colorView.frame.size.width / 2
        cell.setData(hexColor: (productModel?.variationsOverview?.listColor[indexPath.row])!)
        cell.backgroundColor = .clear
        return cell
    }
    
}

