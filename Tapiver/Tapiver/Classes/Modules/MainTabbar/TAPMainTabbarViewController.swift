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
        feedVC.tabBarItem.image = UIImage(named: "feed")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        feedVC.tabBarItem.selectedImage = UIImage(named: "feed_active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        feedVC.title = "Feed"
        
        let discoverVC = TAPDiscoverViewController(nibName: "TAPDiscoverViewController", bundle: nil)
        discoverVC.tabBarItem.image = UIImage(named: "discover")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        discoverVC.tabBarItem.selectedImage = UIImage(named: "discover_active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        discoverVC.title = "Discover"
        
        let dealsVC = TAPDealsViewController(nibName: "TAPDealsViewController", bundle: nil)
        dealsVC.tabBarItem.image = UIImage(named: "deals")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        dealsVC.tabBarItem.selectedImage = UIImage(named: "deals_active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        dealsVC.title = "Deals"
        
        let CategoryVC = TAPCategoryViewController(nibName: "TAPCategoryViewController", bundle: nil)
        CategoryVC.tabBarItem.image = UIImage(named: "category")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        CategoryVC.tabBarItem.selectedImage = UIImage(named: "category_active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        CategoryVC.title = "Category"
        
        let controllers:[UIViewController] = NSArray.init(objects: feedVC, discoverVC, dealsVC, CategoryVC) as! [UIViewController]
        self.viewControllers = controllers
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.init(netHex: 0x175C7A)], for: UIControlState.selected)
        UITabBar.appearance().barTintColor = UIColor.init(netHex: 0x696A6A)
    }

}
