//
//  TAPCartTableViewCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SDWebImage

protocol TAPCartTableViewCellDelegate: class {
    func cartCellDeleteItem(productVariationId: Int)
    func cartCellChangeQuantity()
}

class TAPCartTableViewCell: UITableViewCell {

    @IBOutlet weak var lbQuantity: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityView: TAPDropdownBoxView!
    @IBOutlet weak var removeBtn: UIButton!
    
    public var isReviewOrder: Bool = false
    weak var delegate: TAPCartTableViewCellDelegate?
    var productVariationModel: TAPProductVariationModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.cornerRadius = 5.0
        containerView.layer.masksToBounds = true
        
        quantityView.valueList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        quantityView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(data: TAPProductVariationModel?) {
        productVariationModel = data
        guard let product = data else {
            return
        }
        let imageURL = URL.init(string: product.pictureUrl ?? "")
        avatarImgView.sd_setImage(with: imageURL, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
        brandLabel.text = product.brand
        nameLabel.text = product.name
        
        var des = ""
        let color = product.colorName ?? ""
        let size = product.size != nil ? "\(product.size!)" : ""
        if color.isEmpty == false, size.isEmpty == false {
            des = "\(color)-\(size)"
        } else {
            des = "\(color)\(size)"
        }
        descriptionLabel.text = des
        let price = NSNumber(value: product.finalPrice ?? 0).moneyString()
        priceLabel.text = price
        quantityView.setSelectedValue("\(product.quantity ?? 0)")
        lbQuantity.text = "Quantity: \(data?.quantity ?? 0)"
        lbQuantity.isHidden = !isReviewOrder
        quantityView.isHidden = isReviewOrder
    }
    
    @IBAction func removeBtnTouched(_ sender: Any) {
        if let productId = productVariationModel?.id {
            delegate?.cartCellDeleteItem(productVariationId: productId)
        }   
    }
    
}

extension TAPCartTableViewCell: TAPDropdownBoxViewDelegate {
    func dropdownBox(_ dropdownBox: TAPDropdownBoxView, selectedValue: String?) {
        if let value = selectedValue, let intValue = Int(value) {
            productVariationModel?.quantity = intValue
            delegate?.cartCellChangeQuantity()
        }
        
    }
}
