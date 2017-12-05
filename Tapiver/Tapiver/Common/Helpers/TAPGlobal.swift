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
}
