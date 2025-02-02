//
//  TAPMainPageHeaderView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/14/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

protocol TAPMainPageHeaderViewDelegate: TAPBaseHeaderViewDelegate  {
    func headerViewDidTouchLeftMenu()
}

extension TAPMainPageHeaderViewDelegate {
    func headerViewDidTouchLeftMenu() {}
}

class TAPMainPageHeaderView: TAPBaseHeaderView {
    @IBOutlet weak var searchTextField: UITextField!
    weak var delegate: TAPMainPageHeaderViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let views = Bundle.main.loadNibNamed("TAPMainPageHeaderView", owner: self, options: nil)
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
    
    // MARK: Action methods

    @IBAction func leftMenuTouched(_ sender: Any) {
        self.createLandMark()
        delegate?.headerViewDidTouchLeftMenu()
    }
    
    @IBAction func cartTouched(_ sender: Any) {
        handleCartTouch()
        delegate?.headerViewDidTouchCart()
    }
    
    @IBAction func rightMenuTouched(_ sender: Any) {
        handleMenuTouch()
        delegate?.headerViewDidTouchMenu()
    }
    
    // MARK: Private methods
    private func setupView() {
        
    }
    
    // MARK: Create LandMarkView
    private func createLandMark() {
        let landMark:TAPLandMarkView = TAPLandMarkView.init(frame: (WINDOW?.frame)!)
        landMark.delegate = self
        landMark.initData()
        UIApplication.shared.keyWindow?.addSubview(landMark)
    }
    
}

extension TAPMainPageHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        
        handleSearchTouch()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        delegate?.headerViewDidTouchSearch()
    }
}

extension TAPMainPageHeaderView: TAPLandMarkViewDelegate {
    func landMarkSelectAt(index: Int, isSelect: Bool) {
    }
    
}

