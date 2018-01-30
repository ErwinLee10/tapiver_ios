//
//  TAPBaseViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/11/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPBaseViewController: UIViewController {
    @IBOutlet weak var headerView: TAPBaseHeaderView?
    @IBOutlet var headerTopConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(netHex: 0xF5F8F7)
        
        if #available(iOS 11.0, *) {
            
        } else {
            headerTopConstraint?.constant = 20.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showRightMenu() {
        let menu = TAPMenuViewController.menuViewController { [weak self] (index) in
            self?.menuItemTouchHandler(itemIndex: index)
        }
        menu.modalPresentationStyle = .popover
        menu.popoverPresentationController?.delegate = self
        
        menu.preferredContentSize = CGSize(width: 200, height: 200)
        if let headerView = self.headerView {
            menu.popoverPresentationController?.sourceView = headerView.menuButton
            let menuBtnFrame = headerView.menuButton.frame
            menu.popoverPresentationController?.sourceRect = CGRect(x: menuBtnFrame.width/2, y: menuBtnFrame.height, width: 1, height: 5)
            self.present(menu, animated: true, completion: nil)
        }
    }
    
    func openProductPage(product: TAPProductModel?, feedModel: TAPFeedModel?) {
        guard let newProduct = product else {
            return
        }
        let productViewController: TAPProductMainPageViewController = TAPProductMainPageViewController(nibName: "TAPProductMainPageViewController", bundle: nil)
        productViewController.setData(id: newProduct.id ?? "", title: feedModel?.sellerName ?? "")
        TAPMainFrame.getNavi().pushViewController(productViewController, animated: true)
    }
    
    fileprivate func menuItemTouchHandler(itemIndex: Int) {
        guard TAPGlobal.shared.hasLogin() == true else {
             TAPMainFrame.showLoginPageMain()
            return
        }
        
        switch itemIndex {
//        case 0:
//            break
        case 0:
            showHistoryScreen()
            break
        case 1:
            showCashbackScreen()
            break
        case 2:
            showAccountScreen()
            break
        case 3:
            //show feedback
            showFeedback()
            break
        default:
            break
        }
    }
    
    fileprivate func showHistoryScreen() {
        let vc = TAPHistoryViewController(nibName: "TAPHistoryViewController", bundle: nil)
        TAPMainFrame.getNavi().pushViewController(vc, animated: true)
    }
    fileprivate func showCashbackScreen() {
        let vc = TAPCashbackView(nibName: "TAPCashbackView", bundle: nil)
        TAPMainFrame.getNavi().pushViewController(vc, animated: true)
    }
    fileprivate func showAccountScreen() {
        
        // present TAPAccountViewController
        let accountViewController: TAPAccountTableViewController = TAPAccountTableViewController(nibName: "TAPAccountTableViewController", bundle: nil)
        TAPMainFrame.getNavi().pushViewController(accountViewController, animated: true)
    }
    
    fileprivate func showFeedback() {
        let vc = TAPHistoryReportIssueViewController(nibName: "TAPHistoryReportIssueViewController", bundle: nil)
        TAPMainFrame.getNavi().pushViewController(vc, animated: true)
    }
}

extension TAPBaseViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
