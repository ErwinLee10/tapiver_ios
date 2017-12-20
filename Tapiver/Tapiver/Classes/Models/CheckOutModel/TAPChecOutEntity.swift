//
//  TAPChecOutEntity.swift
//  Tapiver
//
//  Created by HungVT on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
enum CheckOutEntytiType: Int {
    case headerShippingAddress
    case headerBillingAddress
    case address
    case addNewAdressShipping
    case addNewAdressBilling
    case shippingMethod
}
class TAPChecOutEntity: TAPBaseEntity {
    var typeCheckOutCell: CheckOutEntytiType! = .headerShippingAddress
    var addObj: TAPAddressModel?
}

class TAPListChecOutEntity: TAPBaseEntity {
    var listCheckOut: [TAPChecOutEntity] = []
    override func parserResponseArray(dics: [NSDictionary]) {
        super.parserResponseArray(dics: dics)
        for dict in dics {
            let item =  TAPChecOutEntity()
            item.parserResponse(dic: dict)
            listCheckOut.append(item)
        }
    }
    
}
