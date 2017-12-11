//
//  TAPHeaderView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/11/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

protocol TAPHeaderViewDelegate: class {
    func headerViewDidTouchBack()
    func headerViewDidTouchSearch()
    func headerViewDidTouchCard()
    func headerViewDidTouchMenu()
}

extension TAPHeaderViewDelegate {
    func headerViewDidTouchBack() {}
    func headerViewDidTouchSearch() {}
    func headerViewDidTouchCard() {}
    func headerViewDidTouchMenu() {}
}

class TAPHeaderView: UIView {
    
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
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: mainView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mainView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mainView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: mainView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        
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
    
    // MARK: Private methods
    private func setupView() {
        bgImageView.isHidden = false
        bgImageView.alpha = 0.0
    }
    
    // MARK: Actions
    
    @IBAction func backTouched(_ sender: Any) {
        print("Back touch")
        delegate?.headerViewDidTouchBack()
    }
    
    @IBAction func searchTouched(_ sender: Any) {
        print("searchTouched")
        delegate?.headerViewDidTouchSearch()
    }
    
    @IBAction func cartTouched(_ sender: Any) {
        print("cartTouched")
        delegate?.headerViewDidTouchCard()
    }
    
    @IBAction func menuTouched(_ sender: Any) {
        print("menuTouched")
        delegate?.headerViewDidTouchMenu()
    }
    
}
