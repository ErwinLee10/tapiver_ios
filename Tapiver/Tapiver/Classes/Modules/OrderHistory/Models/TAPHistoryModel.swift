//
//  TAPHistoryModel.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/21/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPHistoryModel: TAPBaseEntity {
    var orderList: [TAPOrderModel] = []
    
    override func parserResponseArray(dics: [NSDictionary]) {
        for item in dics {
            let orderModel = TAPOrderModel()
            orderModel.parserResponse(dic: item)
            orderList.append(orderModel)
        }
    }
}
