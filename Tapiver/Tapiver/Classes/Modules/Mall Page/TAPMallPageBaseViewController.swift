//
//  TAPMallPageBaseViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/13/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPMallPageBaseViewController: TAPBaseViewController {
    @IBOutlet var mainHeaderHeight: NSLayoutConstraint!
    
    var landmark: TAPLandmarkModel?
    let expandHeaderHeight: CGFloat = 90.0
    let collapseHeaderHeight: CGFloat = 44.0
    let animationDuration = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabbarVC = tabBarController as! TAPMallPageTabBarViewController
        landmark = tabbarVC.landmark
    }
    
    func setupView() {
        let header  = headerView as? TAPHeaderView
        header?.expandViewAnimation(true)
        mainHeaderHeight.constant = expandHeaderHeight
        
        header?.setHeaderTitle(landmark?.name ?? "")
        header?.setBackgroundImage(imageUrl: landmark?.picture ?? "")
    }

}

extension TAPMallPageBaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerView = headerView as? TAPHeaderView else {
            return
        }
        
        let contentOffset = scrollView.contentOffset.y
        let baseContentOffset: CGFloat = 10.0
        
        if contentOffset > baseContentOffset {
            if headerView.isExpand {
                mainHeaderHeight.constant = collapseHeaderHeight
                UIView.animate(withDuration: animationDuration, animations: {
                    headerView.expandViewAnimation(false)
                    self.view.layoutIfNeeded()
                }) { (isComplete) in
                    
                }
            }
        } else if contentOffset < -baseContentOffset {
            if headerView.isExpand == false {
                mainHeaderHeight.constant = expandHeaderHeight
                UIView.animate(withDuration: animationDuration, animations: {
                    headerView.expandViewAnimation(true)
                    self.view.layoutIfNeeded()
                }) { (isComplete) in
                    
                }
            }
        }
    }
}
