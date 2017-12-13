//
//  TAPMainPageHeaderView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/14/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

protocol TAPMainPageHeaderViewDelegate: class {
    func mainPageHeaderViewDidTouchLeftMenu()
    func mainPageHeaderViewDidTouchRightMenu()
    func mainPageHeaderViewDidTouchCart()
    func mainPageHeaderViewDidTouchSearch()
}

extension TAPMainPageHeaderViewDelegate {
    func mainPageHeaderViewDidTouchLeftMenu() {}
    func mainPageHeaderViewDidTouchRightMenu() {}
    func mainPageHeaderViewDidTouchCart() {}
    func mainPageHeaderViewDidTouchSearch() {}
}

class TAPMainPageHeaderView: UIView {
    @IBOutlet weak var searchTextField: UITextField!
    weak var delegate: TAPMainPageHeaderViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let views = Bundle.main.loadNibNamed("TAPMainPageHeaderView", owner: self, options: nil)
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
    
    // MARK: Action methods

    @IBAction func leftMenuTouched(_ sender: Any) {
        delegate?.mainPageHeaderViewDidTouchLeftMenu()
    }
    
    @IBAction func cartTouched(_ sender: Any) {
        delegate?.mainPageHeaderViewDidTouchCart()
    }
    
    @IBAction func rightMenuTouched(_ sender: Any) {
        delegate?.mainPageHeaderViewDidTouchRightMenu()
    }
    
    // MARK: Private methods
    private func setupView() {
        
    }
}

extension TAPMainPageHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        delegate?.mainPageHeaderViewDidTouchSearch()
    }
}
