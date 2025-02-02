//
//  TAPFeedTableViewCell.swift
//  Tapiver
//
//  Created by HungHN on 12/8/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol TAPFeedTableViewCellDelegate {
    @objc optional func tapIteamAt (index: IndexPath , item: TAPProductModel)
    @objc optional func tapShop(at row: Int)
    @objc optional func followShop(at row: Int)
}
enum MainPageViewType: Int {
    case MainPageViewTypeFeed
    case MainPageViewTypeDiscover
}

class TAPFeedTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionHot: UICollectionView!
    @IBOutlet private weak var ivAvatar: UIImageView!
    @IBOutlet private weak var followBtn: UIButton!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var titleLbl: UILabel!
    
    var items:[TAPProductModel] = []
    var typeView: MainPageViewType?
    weak var delegate :TAPFeedTableViewCellDelegate?
    var row: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionHot.delegate = self
        collectionHot.dataSource = self
        collectionHot.register(UINib.init(nibName: "TAPFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TAPFeedCollectionViewCell")
    }
    
    func fillDataToView(model: TAPFeedModel) {
        ivAvatar.sd_setImage(with: URL.init(string: model.sellerPicture ?? ""), completed: nil)
        nameLbl.text = model.sellerName
        titleLbl.text = model.sellerAddress?.streetName
        items = model.products ?? []
        collectionHot.reloadData()
        followBtn.setTitle(model.isFollowedByThisUser ? "FOLLOWING" : "FOLLOW", for: UIControlState.normal)
    }
    
    @IBAction func shopTouched(_ sender: Any) {
        if let row = self.row {
            delegate?.tapShop?(at: row)
        }
    }
    @IBAction func followButtonTap(_ sender: UIButton) {
        if let row = self.row {
            delegate?.followShop?(at: row)
        }
        
    }
}

extension TAPFeedTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TAPFeedCollectionViewCell", for: indexPath) as? TAPFeedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.fillDataToView(model: items[indexPath.item])
        cell.hiddenViewAll(isHidden: indexPath.item != items.count - 1)
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            let item = items[indexPath.row]
            delegate?.tapIteamAt!(index: indexPath, item: item)
        }
    }
}

extension TAPFeedTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let width = height * 3 / 4
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

extension TAPFeedTableViewCell: TAPFeedCollectionViewCellDelegate {
    func selectCell(indexPath: IndexPath) {
        if delegate != nil {
            let item = items[indexPath.row]
            delegate?.tapIteamAt!(index: indexPath, item: item)
        }
    }
    
    
}
