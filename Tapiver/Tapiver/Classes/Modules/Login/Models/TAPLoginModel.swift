//
//  TAPLoginModel.swift
//  Tapiver
//
//  Created by Phuc on 11/13/17.
//  Copyright © 2017 HungHoang. All rights reserved.
//

import UIKit

final class TAPLoginModel: NSObject {
    var userName: String?
    var passWord: String?
    // MARK - Public methods
    
    func makeParamsForLogin() -> [String : Any] {
        return ["user_name": self.userName ?? "",
                "pass_word": self.passWord ?? ""]
    }
    
}
