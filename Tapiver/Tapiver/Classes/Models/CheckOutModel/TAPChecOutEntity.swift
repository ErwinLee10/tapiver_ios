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
    case addressShipping
    case addressBilling
    case addNewAdressShipping
    case addNewAdressBilling
    case shippingMethod
}
class TAPChecOutEntity: TAPBaseEntity {
    var typeCheckOutCell: CheckOutEntytiType! = .headerShippingAddress
    var addObj: TAPAddressModel?
    var isSelected: Bool = false
    var listShipping =  [TAPCartItemModel]()
    
    override func parserResponse(dic: NSDictionary) {
        typeCheckOutCell =  CheckOutEntytiType.addressShipping
        addObj = TAPAddressModel()
        addObj?.parserResponse(dic: dic)
    }
}

class TAPListChecOutEntity: TAPBaseEntity {
    var listCheckOut: [TAPChecOutEntity] = []
    
    override func parserResponseArray(dics: [NSDictionary]) {
        super.parserResponseArray(dics: dics)
        for dict in dics {
            let item =  TAPChecOutEntity()
            item.parserResponse(dic: dict)
            if dict == dics.first {
                item.isSelected = true
            }
            listCheckOut.append(item)
        }
    }
    
}
