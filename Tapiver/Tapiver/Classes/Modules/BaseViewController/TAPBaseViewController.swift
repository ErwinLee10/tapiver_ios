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

        self.view.backgroundColor = UIColor.init(netHex: 0xDEDEDE)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showRightMenu() {
        let menu = TAPMenuViewController.menuViewController { (index) in
            
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
}

extension TAPBaseViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
