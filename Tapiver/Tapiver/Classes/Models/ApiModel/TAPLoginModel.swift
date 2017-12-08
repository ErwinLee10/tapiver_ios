//
//  TAPLoginModel.swift
//  Tapiver
//
//  Created by hunghoang on 12/2/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPLoginModel: TAPBaseEntity,  NSCoding {
    var userId: String?
    var webSessionId: String?
    override func parserResponse(dic: NSDictionary) {
        userId = String.init(format: "%d",dic.value(forKey: "userId") as? Int ?? 0)
        webSessionId = dic.value(forKey: "webSessionId") as? String
    }
    
    override init() {
        self.userId = ""
        self.webSessionId = ""
    }

    required init(coder decoder: NSCoder) {
        self.userId = decoder.decodeObject(forKey: "userId") as? String ?? ""
        self.webSessionId = decoder.decodeObject(forKey: "webSessionId") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(userId, forKey: "userId")
        coder.encode(webSessionId, forKey: "webSessionId")
    }
}
/*
{
    "userId" : 1,
    "webSessionId": "some long string"    // credential for making requests to other APIs
}
*/
