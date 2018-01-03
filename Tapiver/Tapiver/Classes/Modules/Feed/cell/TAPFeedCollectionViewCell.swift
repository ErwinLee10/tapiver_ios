//
//  TAPFeedCollectionViewCell.swift
//  Tapiver
//
//  Created by HungHN on 12/7/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SDWebImage

protocol TAPFeedCollectionViewCellDelegate {
    func selectCell(indexPath: IndexPath)
}

class TAPFeedCollectionViewCell: UICollectionViewCell {
    
    //@IBOutlet private weak var pageView: iCarousel!
    //@IBOutlet private weak var pageControl: UIPageControl!
	@IBOutlet weak var productImage: UIImageView!
	@IBOutlet weak var collectionContainerView: UIView!
	@IBOutlet weak var colorCollectionView: UICollectionView!
	@IBOutlet weak var colorCollectionViewWidth: NSLayoutConstraint!
	var colorData: [String]?
	
	@IBOutlet private weak var ivHotNew: UIImageView!
    @IBOutlet private weak var persentSaleLbl: UILabel!
    @IBOutlet private weak var ivFree: UIImageView!
    @IBOutlet private weak var likeBtn: UIButton!
    @IBOutlet private weak var numberLikeLbl: UILabel!
    @IBOutlet private weak var nameProdctLbl: UILabel!
    @IBOutlet private weak var contentLbl: UILabel!
    @IBOutlet private weak var fromLbl: UILabel!
    @IBOutlet private weak var priceLbl: UILabel!
    @IBOutlet private weak var newPriceLbl: UILabel!
    @IBOutlet weak var viewAllView: UIView!
    
    
    private var currentIdex: Int = 0
    private var items: [String]  = []
    
    var delegate: TAPFeedCollectionViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupPageView()
        
    }
    
    func setupPageView() {
//        self.pageView.type = .linear
//        self.pageView.isPagingEnabled = true
//        self.pageView.delegate = self
//        self.pageView.dataSource = self
//        self.pageControl.numberOfPages = items.count
    }
    
    func hiddenViewAll(isHidden: Bool) {
        self.viewAllView.isHidden = isHidden
    }
    
    func fillDataToView(model: TAPProductModel) {
        let isNew: Bool = model.variationsOverview?.labels?.contains("NEW") ?? false
        let isHot: Bool = model.variationsOverview?.labels?.contains("HOT") ?? false
        ivHotNew.isHidden = !isNew && !isHot
        ivHotNew.image = UIImage.init(named: isHot ? "banner_hot" : (isNew ? "banner_new" : ""))
        let isFree: Bool = model.variationsOverview?.labels?.contains("FREE_SHIPPING") ?? false
        ivFree.isHidden = !isFree
        likeBtn.setImage(UIImage.init(named: model.isLikedByThisUser ? "icon_thumbs_on" : "icon_thumbs_off"), for: UIControlState.normal)
        numberLikeLbl.text = String.init(model.likes)
        nameProdctLbl.text = model.brand
        contentLbl.text = model.name
//        items = model.variationsOverview?.pictures ?? []
		
		if checkIfHasManyColor() == false {
			collectionContainerView.isHidden = true
		}
		else {
			colorCollectionView.delegate = self
			colorCollectionView.dataSource = self
//			colorTableView.frame = CGRect(x: colorTableView.frame.origin.x, y: colorTableView.frame.origin.y, width: colorTableView.frame.size.width, height: colorTableView.contentSize.height)
			if listColor.count <= 4 {
				colorTableViewHeight.constant = CGFloat(listColor.count * 38)
			}
			else {
				colorTableViewHeight.constant = CGFloat(4 * 38)
			}
		}
//        self.pageControl.numberOfPages = items.count
//        pageView.reloadData()
		
		
        let price = model.variationsOverview?.originalPrice ?? 0
        guard let salePrice = model.variationsOverview?.salePrice else {
            persentSaleLbl.isHidden = true
            newPriceLbl.text = "S$" + String.init(price)
            priceLbl.text = ""
            return
        }
        let percentSale: Int = Int(100 - salePrice * 100 / price)
        persentSaleLbl.text = String.init(percentSale) + "%"
        newPriceLbl.text = "S$" + String.init(salePrice)
        priceLbl.text = "S$" + String.init(price)
        let attributes : [NSAttributedStringKey : Any] = [ NSAttributedStringKey.font : UIFont.systemFont(ofSize: 11.0),
                                            NSAttributedStringKey.foregroundColor : UIColor.init(netHex: 0x848585),
                                            NSAttributedStringKey.strikethroughStyle : NSUnderlineStyle.styleSingle.rawValue]
        let attStringSaySomething = NSAttributedString(string: "S$" + String.init(price), attributes: attributes)
        priceLbl.attributedText = attStringSaySomething
    }
	
	func checkIfHasManyColor(model: TAPProductModel) -> Bool {
		model.variationsOverview
		for item in (data?.variations?.listVariations)! {
			var check = true
			for color in listColor {
				if color == item.colorHexCode {
					check = false
					break
				}
			}
			if check {
				listColor.append(item.colorHexCode!)
			}
			
		}
		if listColor.count > 1 {
			return true
		}
		else {
			return false
		}
	}
}

extension TAPFeedCollectionViewCell: UICollectionViewDelegate {
	
}

extension TAPFeedCollectionViewCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if colorData != nil {
			return (colorData?.count)!
		}
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TAPFeedColorCollectionViewCell", for: indexPath) as! TAPFeedColorCollectionViewCell
		cell.setData(hexColor: colorData![indexPath.row])
		cell.backgroundColor = .clear
		return cell
	}
	
	
}

//extension TAPFeedCollectionViewCell: iCarouselDataSource, iCarouselDelegate {
//
//    func numberOfItems(in carousel: iCarousel) -> Int {
//        return items.count
//    }
//
//    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
//        var itemView: UIImageView
//        //reuse view if available, otherwise create a new view
//        if let view = view as? UIImageView {
//            itemView = view
//        } else {
//            //don't do anything specific to the index within
//            //this `if ... else` statement because the view will be
//            //recycled and used with other index values later
//            let frame = carousel.frame
//            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
//            itemView.contentMode = .scaleAspectFit
//            itemView.layer.masksToBounds = true
//        }
//
//        itemView.sd_setImage(with: URL.init(string: items[index]), completed: nil)
//        return itemView
//    }
//
//    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
//         pageControl.currentPage = carousel.currentItemIndex
//    }
//
//    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
//        if (option == .wrap) {
//            return value * 1.05
//
//        } else if (option == .spacing) {
//            return 1.0
//        } else if (option == .fadeMax) {
//            if (carousel.type == .custom) {
//                //set opacity based on distance from camera
//                return 0.0
//            }
//            return value;
//        }
//        return value
//    }
//
//    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
//        delegate?.selectCell(indexPath: indexPath!)
//    }
//
//}




