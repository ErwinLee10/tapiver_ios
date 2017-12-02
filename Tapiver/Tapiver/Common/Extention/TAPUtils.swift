//
//  TAPUtils.swift
//  Tapiver
//
//  Created by hunghoang on 12/2/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPUtils: NSObject {
    static let shareInstance = TAPUtils()
    override init() {
    }
    
    func isValidEmail(email:String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
