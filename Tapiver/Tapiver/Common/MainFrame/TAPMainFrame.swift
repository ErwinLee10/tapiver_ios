//
//  TAPMainFrame.swift
//  Tapiver
//
//  Created by HungHN on 11/28/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

var navigationView:UINavigationController?
class TAPMainFrame: NSObject {
    
    static func makeNewMainFrame () -> UIViewController! {
        let naviRoot: UIViewController
        
        if(TAPGlobal.shared.hasLogin()) {
            naviRoot = TAPMainTabbarViewController(nibName: "TAPMainTabbarViewController", bundle: nil)
        } else {
            naviRoot = TAPIntroAppViewController(nibName: "TAPIntroAppViewController", bundle: nil)
        }
        navigationView = self.makeCenterNavi(controller: naviRoot)
        return navigationView
    }
    
    static func makeCenterNavi (controller: UIViewController) -> UINavigationController {
        let navi = UINavigationController(rootViewController: controller)
        navi.navigationBar.isTranslucent = false
        navi.navigationBar.isHidden = true
        return navi
    }

    static func showLoginPageMain() -> Void {
        let vc = TAPLoginPageMainViewController(nibName: "TAPLoginPageMainViewController", bundle: nil)
        navigationView?.viewControllers = [vc]
        
    }
    
    static func showMainTabbarPage() -> Void {
        let vc = TAPMainTabbarViewController(nibName: "TAPMainTabbarViewController", bundle: nil)
        navigationView?.viewControllers = [vc]
        
    }
    
    static func showForgotPage() -> Void {
        let vc = TAPForgotPasswordViewController(nibName: "TAPForgotPasswordViewController", bundle: nil)
        navigationView?.pushViewController(vc, animated: true)
        
    }
    
    static func showSignupEmailPage() -> Void {
        let vc = TAPSignupEmailViewController(nibName: "TAPSignupEmailViewController", bundle: nil)
        navigationView?.pushViewController(vc, animated: true)
        
    }
    
    static func showSignupEmailPage(email: String?, firstName: String?, lastName: String?) -> Void {
        let vc = TAPSignupEmailViewController(nibName: "TAPSignupEmailViewController", bundle: nil)
        vc.email = email
        vc.firstName = firstName
        vc.lastName = lastName
        navigationView?.pushViewController(vc, animated: true)
//        navigationView?.viewControllers = [vc]
        
    }
    
    static func showSignupPassPage(email:String, firstName:String?, lastName:String?) -> Void {
        let vc = TAPSignupPasswordViewController(nibName: "TAPSignupPasswordViewController", bundle: nil)
        vc.email = email
        vc.firstName = firstName
        vc.lastName = lastName
        navigationView?.pushViewController(vc, animated: true)
//        navigationView?.viewControllers = [vc]
        
    }
    
    static func getNavi() -> UINavigationController{
        return navigationView!
    }
}
