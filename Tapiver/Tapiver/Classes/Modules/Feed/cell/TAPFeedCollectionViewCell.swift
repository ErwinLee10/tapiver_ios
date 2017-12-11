//
//  TAPFeedCollectionViewCell.swift
//  Tapiver
//
//  Created by HungHN on 12/7/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SDWebImage


class TAPFeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pageView: iCarousel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var currentIdex: Int = 0
    private var items: [String]  = ["https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/a846094c-9b74-41ae-8f24-8a943e1192ff.jpg","https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/5e431a84-43d3-4774-b5b8-bc52a7d5c9cd.jpg","https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/74fc8cb8-4b35-47a1-a90e-81e76f950912.jpg"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupPageView()
        
    }
    
    func setupPageView() {
        self.pageView.type = .linear
        self.pageView.isPagingEnabled = true
        self.pageView.delegate = self
        self.pageView.dataSource = self
        
        self.pageControl.numberOfPages = items.count
    }
}

extension TAPFeedCollectionViewCell: iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return items.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            let frame = carousel.frame
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
            itemView.contentMode = .scaleAspectFit
            itemView.layer.masksToBounds = true
        }
        
        itemView.sd_setImage(with: URL.init(string: items[index]), completed: nil)
        return itemView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
         pageControl.currentPage = carousel.currentItemIndex
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .wrap) {
            return value * 1.05
            
        } else if (option == .spacing) {
            return 1.0
        } else if (option == .fadeMax) {
            if (carousel.type == .custom) {
                //set opacity based on distance from camera
                return 0.0
            }
            return value;
        }
        return value
    }
    
}




