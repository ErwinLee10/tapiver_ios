//
//  TAPLoginModel.swift
//  Tapiver
//
//  Created by hunghoang on 12/2/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPLoginModel: TAPBaseEntity {
    var userId: String?
    var webSessionId: String?
    override func parserResponse(dic: NSDictionary) {
        userId = dic.value(forKey: "userId") as? String
        webSessionId = dic.value(forKey: "webSessionId") as? String
    }
}
/*
{
    "userId" : 1,
    "webSessionId": "some long string"    // credential for making requests to other APIs
}
*/
