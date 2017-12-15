//
//  TAPLandMark.swift
//  Tapiver
//
//  Created by HungVT on 12/15/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
class TAPListLandMark: TAPBaseEntity {
    var listLandMark: [TAPLandMark]? = []
    override func parserResponseArray(dics: [NSDictionary]) {
        super.parserResponseArray(dics: dics)
        for dict in dics {
            let item =  TAPLandMark()
            item.parserResponse(dic: dict)
            listLandMark?.append(item)
        }
    }
}


class TAPLandMark: TAPBaseEntity {
    var name: String?
    var idLandMark: Int?
    var pictureUrl: String?
    
    override func parserResponse(dic: NSDictionary ) {
        self.idLandMark = dic.value(forKey: "id") as? Int
        self.name = dic.value(forKey: "name") as? String
        self.pictureUrl = dic.value(forKey: "picture") as? String
    }
}
