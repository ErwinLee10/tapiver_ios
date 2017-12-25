//
//  AppDelegate.swift
//  Tapiver
//
//  Created by hunghoang on 11/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Stripe SDK
        setPublishableKey()
        // Facebook SDK
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = LaunchScreenCustom(nibName: "LaunchScreenCustom", bundle: nil)
        self.window!.makeKeyAndVisible()
        
        TAPWebservice.shareInstance.sendGETRequest(path: "/api/v1/ios-info", params: [:], responseObjectClass: TAPVersionModel()) { (check, value) in
            if check {
                let data = value as? TAPVersionModel
                
                guard let minimumVersionSupportedName = data?.minimumVersionSupportedName else { return }
                guard let minimumVersionSupported = Double(minimumVersionSupportedName) else { return }
                
                let appVersionName = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                guard let appVersion = Double(appVersionName) else { return }
                
                if appVersion < minimumVersionSupported {
                    TAPGlobal.shared.dismissLoading()
                    let updateView = Bundle.main.loadNibNamed("TAPRequestUpdateApp", owner: self, options: nil)![0] as? TAPRequestUpdateApp
                    updateView?.frame = (UIApplication.shared.keyWindow?.frame)!
                    UIApplication.shared.keyWindow?.addSubview(updateView!)
                }
                else {
                    let navi = TAPMainFrame.makeNewMainFrame()
                    self.window!.rootViewController = navi
                }
            }
            else {
                let navi = TAPMainFrame.makeNewMainFrame()
                self.window!.rootViewController = navi
            }
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        // Add any custom logic here.
        return handled;
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if #available(iOS 9.0, *) {
            return self.application(application: app, openURL: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?, annotation: options[UIApplicationOpenURLOptionsKey.sourceApplication] as AnyObject)
        } else {
            // Fallback on earlier versions
            return true
        }
    }
    private func setPublishableKey() {
        Stripe.setDefaultPublishableKey(STRIPE_PUBLISHABLE_KEY)
    }
}

