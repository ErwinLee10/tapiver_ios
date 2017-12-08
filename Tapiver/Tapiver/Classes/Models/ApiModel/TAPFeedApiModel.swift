//
//  TAPFeedApiModel.swift
//  Tapiver
//
//  Created by HungHN on 12/8/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPFeedApiModel: TAPBaseEntity {
    var feedModels: [TAPFeedModel] = []
    
    override func parserResponse(dic: NSDictionary) {
        
    }
    
    override func parserResponseArray(dics: [NSDictionary]) {
        for dic in dics {
            let model = TAPFeedModel()
            model.parserResponse(dic: dic)
            feedModels.append(model)
        }
    }
}
