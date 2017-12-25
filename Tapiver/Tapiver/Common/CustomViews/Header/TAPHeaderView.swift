//
//  TAPHeaderView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/11/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SDWebImage

protocol TAPHeaderViewDelegate: TAPBaseHeaderViewDelegate {
}

class TAPHeaderView: TAPBaseHeaderView {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    weak var delegate: TAPHeaderViewDelegate?
    
    var isExpand = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let views = Bundle.main.loadNibNamed("TAPHeaderView", owner: self, options: nil)
        let mainView = views?[0] as! UIView
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
    
    // MARK: Public methods
    
    func setHeaderTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setBackgroundImage(imageUrl: String) {
        bgImageView.sd_setImage(with: URL.init(string: imageUrl), placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
    }
    
    func expandViewAnimation(_ expand: Bool) {
        isExpand = expand
        if expand {
            bgImageView.alpha = 1.0
            titleLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        } else {
            bgImageView.alpha = 0.0
            titleLabel.font = UIFont.systemFont(ofSize: 17.0)
        }
    }
    
    func hideSearchButton(_ hide: Bool) {
        searchButton.isHidden = hide
    }
    
    func hideCartButton(_ hide: Bool) {
        cartButton.isHidden = hide
    }
    
    func hideMenuButton(_ hide: Bool) {
        menuButton.isHidden = hide
    }
    
    // MARK: Actions
    
    @IBAction func backTouched(_ sender: Any) {
        print("Back touch")
        handleBackTouch()
        delegate?.headerViewDidTouchBack()
    }
    
    @IBAction func searchTouched(_ sender: Any) {
        print("searchTouched")
        handleSearchTouch()
        delegate?.headerViewDidTouchSearch()
    }
    
    @IBAction func cartTouched(_ sender: Any) {
        print("cartTouched")
        handleCartTouch()
        delegate?.headerViewDidTouchCart()
    }
    
    @IBAction func menuTouched(_ sender: Any) {
        print("menuTouched")
        handleMenuTouch()
        delegate?.headerViewDidTouchMenu()
    }
    
    // MARK: Private methods
    private func setupView() {
        bgImageView.isHidden = false
        bgImageView.alpha = 0.0
    }
    
}
