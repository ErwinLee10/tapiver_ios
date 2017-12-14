//
//  TAPMainPageHeaderView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/14/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

protocol TAPMainPageHeaderViewDelegate: TAPBaseHeaderViewDelegate {
    func headerViewDidTouchLeftMenu()
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
    }
    
    // MARK: Public methods
    
    // MARK: Action methods

    @IBAction func leftMenuTouched(_ sender: Any) {
        delegate?.headerViewDidTouchLeftMenu()
    }
    
    @IBAction func cartTouched(_ sender: Any) {
        delegate?.headerViewDidTouchCart()
    }
    
    @IBAction func rightMenuTouched(_ sender: Any) {
        delegate?.headerViewDidTouchMenu()
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
        delegate?.headerViewDidTouchSearch()
    }
}
