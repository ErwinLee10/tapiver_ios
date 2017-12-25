
//
//  TAPStorePageHeaderView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/14/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SDWebImage

protocol TAPStorePageHeaderViewDelegate: TAPBaseHeaderViewDelegate {
    func headerViewDidTouchInfo()
    func headerViewDidTouchFollow()
}

class TAPStorePageHeaderView: TAPBaseHeaderView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var avatarContainer: TAPCircleView!
    @IBOutlet weak var followContainer: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    weak var delegate: TAPStorePageHeaderViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let views = Bundle.main.loadNibNamed("TAPStorePageHeaderView", owner: self, options: nil)
        let mainView = views?[0] as! UIView
        self.backgroundColor = UIColor.clear
        self.addSubview(mainView)
        
        mainView.makeContraintToFullWithParentView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        cartButton.badgeString = TAPGlobal.shared.getCartBadgeNumber()
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeCartNumber(_:)), name: NSNotification.Name(rawValue: TAPConstants.NotificationName.ChangeCartNumber), object: nil)
    }
    
    @objc func changeCartNumber(_ notification: NSNotification) {
        if let dic = notification.object as? NSDictionary {
            if let result = dic["number"] as? String {
                cartButton.badgeString = result
                TAPGlobal.shared.saveCartBadgeNumber(number: result)
            }
        }
    }
    
    func fillData(entity: TAPFeedModel) {
        let imageURL = URL.init(string: entity.sellerPicture ?? "")
        avatarImageView.sd_setImage(with: imageURL, placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
        nameLabel.text = entity.sellerName
        followersLabel.text = "\(entity.sellerTotalFollower ?? 0) Followers"
    }

    @IBAction func backTouched(_ sender: Any) {
        handleBackTouch()
        delegate?.headerViewDidTouchBack()
    }
    
    @IBAction func searchTouched(_ sender: Any) {
        delegate?.headerViewDidTouchSearch()
    }
    
    @IBAction func cartTouched(_ sender: Any) {
        handleCartTouch()
        delegate?.headerViewDidTouchCart()
    }
    
    @IBAction func menuTouched(_ sender: Any) {
        handleMenuTouch()
        delegate?.headerViewDidTouchMenu()
    }
    
    @IBAction func avatarTouched(_ sender: Any) {
        delegate?.headerViewDidTouchInfo()
    }
    
    @IBAction func infoTouched(_ sender: Any) {
        delegate?.headerViewDidTouchInfo()
    }
    
    @IBAction func followTouched(_ sender: Any) {
        delegate?.headerViewDidTouchFollow()
    }
    
    // MARK: Private
    private func setupView() {
        
    }
    
}
