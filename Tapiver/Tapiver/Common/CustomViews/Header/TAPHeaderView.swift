//
//  TAPHeaderView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/11/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

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
    }
    
    // MARK: Public methods
    
    func setHeaderTitle(_ title: String) {
        titleLabel.text = title
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
    
    // MARK: Actions
    
    @IBAction func backTouched(_ sender: Any) {
        print("Back touch")
        handleBackTouch()
        delegate?.headerViewDidTouchBack()
    }
    
    @IBAction func searchTouched(_ sender: Any) {
        print("searchTouched")
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
