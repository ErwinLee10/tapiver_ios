//
//  TAPMainTabbarViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPMainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViewController()
    }
    
    // MARK: Public methods
    // MARK: Private methods
    
    private func setupViewController() {
        self.configTabbar()
        
    }
    
    private func configTabbar() {
        let feedVC = TAPFeedViewController(nibName: "TAPFeedViewController", bundle: nil)
        let naviFeedVC = UINavigationController.init(rootViewController: feedVC)
        naviFeedVC.navigationBar.isTranslucent = false
        naviFeedVC.navigationBar.isHidden = true
        naviFeedVC.tabBarItem.image = UIImage(named: "feed")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        naviFeedVC.tabBarItem.selectedImage = UIImage(named: "feed_active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        naviFeedVC.title = "Feed"
        
        let discoverVC = TAPDiscoverViewController(nibName: "TAPDiscoverViewController", bundle: nil)
        let naviDiscoverVC = UINavigationController.init(rootViewController: discoverVC)
        naviDiscoverVC.navigationBar.isTranslucent = false
        naviDiscoverVC.navigationBar.isHidden = true
        naviDiscoverVC.tabBarItem.image = UIImage(named: "discover")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        naviDiscoverVC.tabBarItem.selectedImage = UIImage(named: "discover_active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        naviDiscoverVC.title = "Discover"
        
        let dealsVC = TAPDealsViewController(nibName: "TAPDealsViewController", bundle: nil)
        let naviDealsVC = UINavigationController.init(rootViewController: dealsVC)
        naviDealsVC.navigationBar.isTranslucent = false
        naviDealsVC.navigationBar.isHidden = true
        naviDealsVC.tabBarItem.image = UIImage(named: "deals")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        naviDealsVC.tabBarItem.selectedImage = UIImage(named: "deals_active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        naviDealsVC.title = "Deals"
        
        let categoryVC = TAPCategoryViewController(nibName: "TAPCategoryViewController", bundle: nil)
        let naviCategoryVC = UINavigationController.init(rootViewController: categoryVC)
        naviCategoryVC.navigationBar.isTranslucent = false
        naviCategoryVC.navigationBar.isHidden = true
        naviCategoryVC.tabBarItem.image = UIImage(named: "category")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        naviCategoryVC.tabBarItem.selectedImage = UIImage(named: "category_active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        naviCategoryVC.title = "Category"
        
        let controllers:[UIViewController] = NSArray.init(objects: naviFeedVC, naviDiscoverVC, naviDealsVC, naviCategoryVC) as! [UIViewController]
        self.viewControllers = controllers
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.init(netHex: 0x848585)], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.init(netHex: 0x195b79)], for: UIControlState.selected)
        UITabBar.appearance().barTintColor = UIColor.init(netHex: 0xF7F9F9)
    }

}
