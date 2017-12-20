//
//  TAPLandMark.swift
//  Tapiver
//
//  Created by HungVT on 12/15/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
class TAPListLandMark: TAPBaseEntity {
    var listLandMark: [TAPLandmarkModel]? = []
    override func parserResponseArray(dics: [NSDictionary]) {
        super.parserResponseArray(dics: dics)
        for dict in dics {
            let item =  TAPLandmarkModel()
            item.parserResponse(dic: dict)
            listLandMark?.append(item)
        }
    }
}

