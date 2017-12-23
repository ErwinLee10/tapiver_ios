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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(netHex: 0xF5F8F7)
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
        
        menu.preferredContentSize = CGSize(width: 200, height: 250)
        if let headerView = self.headerView {
            menu.popoverPresentationController?.sourceView = headerView.menuButton
            let menuBtnFrame = headerView.menuButton.frame
            menu.popoverPresentationController?.sourceRect = CGRect(x: menuBtnFrame.width/2, y: menuBtnFrame.height, width: 1, height: 5)
            self.present(menu, animated: true, completion: nil)
        }
    }
    
    fileprivate func menuItemTouchHandler(itemIndex: Int) {
        guard TAPGlobal.shared.hasLogin() else {
             TAPMainFrame.showLoginPageMain()
            return
        }
        
        switch itemIndex {
        case 0:
            break
        case 1:
            showHistoryScreen()
        case 2:
            break
        case 3:
            showAccountScreen()
        default:
            break
        }
    }
    
    fileprivate func showHistoryScreen() {
        let vc = TAPHistoryViewController(nibName: "TAPHistoryViewController", bundle: nil)
        TAPMainFrame.getNavi().pushViewController(vc, animated: true)
//        let vc = TAPHistoryReportIssueViewController(nibName: "TAPHistoryReportIssueViewController", bundle: nil)
//        TAPMainFrame.getNavi().pushViewController(vc, animated: true)
    }
    
    fileprivate func showAccountScreen() {
        // get top ViewController
        let root = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        let tabBar = root.topViewController as! TAPMainTabbarViewController
        let naviTabBar = tabBar.viewControllers![tabBar.selectedIndex] as! UINavigationController
        let topViewController = naviTabBar.topViewController
        
        // present TAPAccountViewController
        let accountViewController: TAPAccountTableViewController = TAPAccountTableViewController(nibName: "TAPAccountTableViewController", bundle: nil)
        let navi = UINavigationController(rootViewController: accountViewController)
        navi.navigationBar.barTintColor = UIColor.init(netHex: 0x195B79)
        topViewController?.present(navi, animated: true, completion: {
            
        })
    }
}

extension TAPBaseViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
