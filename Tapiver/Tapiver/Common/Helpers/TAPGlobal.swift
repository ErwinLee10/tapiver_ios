//
//  TAPGlobal.swift
//  Tapiver
//
//  Created by HungHN on 12/5/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPGlobal: NSObject {
    static let shared = TAPGlobal()
    
    let userDefault = UserDefaults.standard
    let loadingView = Bundle.main.loadNibNamed("TAPLoadingView", owner: self, options: nil)![0] as? TAPLoadingView
    
    func saveLoginModel(model: TAPLoginModel) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: model)
        self.userDefault.set(encodedData, forKey: "KEY_USER_LOGIN_DATA")
    }
    
    func getLoginModel() -> TAPLoginModel? {
        guard let data = self.userDefault.data(forKey: "KEY_USER_LOGIN_DATA") else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? TAPLoginModel
    }
    
    func saveHasLogin(isLogin: Bool) {
        self.userDefault.set(isLogin, forKey: "KEY_USER_HAS_LOGIN")
    }
    
    func hasLogin() -> Bool{
        return self.userDefault.bool(forKey: "KEY_USER_HAS_LOGIN")
    }
    
    func saveProfileModel(model: TAPProfileModel) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: model)
        self.userDefault.set(encodedData, forKey: "KEY_USER_PROFILE_DATA")
    }
    
    func getProfileModel() -> TAPProfileModel? {
        guard let data = self.userDefault.data(forKey: "KEY_USER_PROFILE_DATA") else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? TAPProfileModel
    }
    
    func deleteProfileModel() {
        self.userDefault.removeObject(forKey: "KEY_USER_PROFILE_DATA")
    }
    
    func deleteLoginModel() {
        self.userDefault.removeObject(forKey: "KEY_USER_LOGIN_DATA")
    }
    
    func getCartBadgeNumber() -> String {
        guard let data = self.userDefault.data(forKey: "KEY_CART_BADGE_NUMBER") else {
            return ""
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! String
    }
    
    func saveCartBadgeNumber(number: String) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: number)
        self.userDefault.set(encodedData, forKey: "KEY_CART_BADGE_NUMBER")
    }
    
    func showLoading() {
        loadingView?.frame = (UIApplication.shared.keyWindow?.frame)!
        UIApplication.shared.keyWindow?.addSubview(loadingView!)
    }
    
    func dismissLoading() {
        loadingView?.removeFromSuperview()
    }
}
