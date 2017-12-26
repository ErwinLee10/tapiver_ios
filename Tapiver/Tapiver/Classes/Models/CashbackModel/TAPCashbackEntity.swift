//
//  TAPCashbackEntity.swift
//  Tapiver
//
//  Created by Hung vu on 12/24/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPCashbackEntity: TAPBaseEntity {

    var idCashback: Int?
    var orderDate: Double?
    var cashbackPercentage: Int?
    var cashbackAmount: Double?
    var status: String?
    var orderId: Int?
    
    override func parserResponse(dic: NSDictionary) {
        idCashback = dic.value(forKey: TAPConstants.APIParams.id) as? Int
        orderDate = dic.value(forKey: TAPConstants.APIParams.orderDate) as? Double
        cashbackPercentage = dic.value(forKey: TAPConstants.APIParams.cashbackPercentage) as? Int
        cashbackAmount = dic.value(forKey: TAPConstants.APIParams.cashbackAmount) as? Double
        status = dic.value(forKey: TAPConstants.APIParams.status) as? String
        orderId = dic.value(forKey: TAPConstants.APIParams.orderId) as? Int
    }
}

class TAPListCashback: TAPBaseEntity {
    var earning: Double?
    var redeemable: Double?
    var redeemed: Double?
    var pending: Double?
    var processing: Int?
    var cashBacks: [TAPCashbackEntity] = []
    override func parserResponse(dic: NSDictionary) {
        earning = dic.value(forKey: TAPConstants.APIParams.earning) as? Double
        redeemable = dic.value(forKey: TAPConstants.APIParams.redeemable) as? Double
        redeemed = dic.value(forKey: TAPConstants.APIParams.redeemed) as? Double
        pending = dic.value(forKey: TAPConstants.APIParams.pending) as? Double
        processing = dic.value(forKey: TAPConstants.APIParams.processing) as? Int
        
        guard let list = dic.value(forKey: TAPConstants.APIParams.cashbacks) as? [Dictionary<String, Any>] else  {
            return
        }
        for item in list {
            let newItem = TAPCashbackEntity()
            newItem.parserResponse(dic: item as NSDictionary)
            cashBacks.append(newItem)
        }
    
    }
    
}

//{
//    "earning": 353.45,
//    "redeemable": 0,
//    "redeemed": 353.45,
//    "pending": 13.2,
//    "processing": 0,
//    "cashbacks": [
//    {
//    "id": 48,
//    "orderDate": 1507332130117,
//    "cashbackPercentage": 5,
//    "cashbackAmount": 83.25,
//    "status": "REDEEMED",
//    "orderId": 315073609301
//    },
//    {
//    "id": 47,
//    "orderDate": 1507331358703,
//    "cashbackPercentage": 5,
//    "cashbackAmount": 9.25,
//    "status": "PENDING",
//    "orderId": 315073601581
//    }
//    ]
//}

