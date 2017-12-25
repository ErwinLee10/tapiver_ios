//
//  TAPBaseHeaderView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/14/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

protocol TAPBaseHeaderViewDelegate: class {
    func headerViewDidTouchBack()
    func headerViewDidTouchSearch()
    func headerViewDidTouchCart()
    func headerViewDidTouchMenu()
}

extension TAPBaseHeaderViewDelegate {
    func headerViewDidTouchBack() {}
    func headerViewDidTouchSearch() {}
    func headerViewDidTouchCart() {}
    func headerViewDidTouchMenu() {}
}

class TAPBaseHeaderView: UIView {
    @IBOutlet weak var cartButton: MIBadgeButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var backButton: UIButton?
    
    
    func handleCartTouch() {
        guard TAPGlobal.shared.hasLogin() else {
            TAPMainFrame.showLoginPageMain()
            return
        }
        let cartVC = TAPCartViewController(nibName: "TAPCartViewController", bundle: nil)
        TAPMainFrame.getNavi().pushViewController(cartVC, animated: true)
    }
    
    func handleSearchTouch() {
        let searchVC = TAPSearchViewController(nibName: "TAPSearchViewController", bundle: nil)
        TAPMainFrame.getNavi().pushViewController(searchVC, animated: true)
    }
    
    func handleBackTouch() {
        TAPMainFrame.getNavi().popViewController(animated: true)
    }
    
    func handleMenuTouch() {
        // Show menu
    }
}
