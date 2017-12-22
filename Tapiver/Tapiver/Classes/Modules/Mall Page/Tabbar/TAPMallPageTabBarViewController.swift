//
//  TAPMallPageTabBarViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/11/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPMallPageTabBarViewController: UITabBarController {
    var landmark: TAPLandmarkModel?
    
    static func mallPageTabBarController(landmark: TAPLandmarkModel?) -> TAPMallPageTabBarViewController {
        let tabbar = TAPMallPageTabBarViewController()
        tabbar.landmark = landmark
        return tabbar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()
    }

    private func configTabbar() {
        // Shops
        let shopVC = TAPMallPageShopViewController.init(nibName: "TAPMallPageShopViewController", bundle: nil)
        let shopNav = UINavigationController(rootViewController: shopVC)
        shopNav.navigationBar.isHidden = true
        shopNav.tabBarItem.image = UIImage(named: "feed")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        shopNav.tabBarItem.selectedImage = UIImage(named: "feed_active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        shopNav.tabBarItem.title = "Shops"
        
        // Deals
        let dealsVC = TAPMallPageDealViewController.init(nibName: "TAPMallPageDealViewController", bundle: nil)
        let dealsNav = UINavigationController(rootViewController: dealsVC)
        dealsNav.navigationBar.isHidden = true
        dealsNav.tabBarItem.image = UIImage(named: "deals")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        dealsNav.tabBarItem.selectedImage = UIImage(named: "deals_active")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        dealsNav.tabBarItem.title = "Deals"
        
        self.viewControllers = [shopNav, dealsNav]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.init(netHex: 0x848585)], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.init(netHex: 0x195b79)], for: UIControlState.selected)
        UITabBar.appearance().barTintColor = UIColor.init(netHex: 0xF7F9F9)
    }

}
