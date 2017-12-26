//
//  TAPOrderItemModel.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/22/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPOrderItemModel: TAPBaseEntity {
    var itemId: String?
    var itemName: String?
    var colorHexCode: String?
    var colorName: String?
    var size: String?
    var quantity: Int?
    var originalPrice: Double?
    var salePrice: Double?
    var discountPercentage: Int?
    var finalPrice: Double?
    var itemPictures: [String] = []
    
    override func parserResponse(dic: NSDictionary) {
        itemId = dic.value(forKey: TAPConstants.APIParams.itemId) as? String
        itemName = dic.value(forKey: TAPConstants.APIParams.itemName) as? String
        colorHexCode = dic.value(forKey: TAPConstants.APIParams.colorHexCode) as? String
        colorName = dic.value(forKey: TAPConstants.APIParams.colorName) as? String
        size = dic.value(forKey: TAPConstants.APIParams.size) as? String
        quantity = dic.value(forKey: TAPConstants.APIParams.quantity) as? Int
        originalPrice = dic.value(forKey: TAPConstants.APIParams.originalPrice) as? Double
        salePrice = dic.value(forKey: TAPConstants.APIParams.salePrice) as? Double
        discountPercentage = dic.value(forKey: TAPConstants.APIParams.discountPercentage) as? Int
        finalPrice = dic.value(forKey: TAPConstants.APIParams.finalPrice) as? Double
        itemPictures = dic.value(forKey: TAPConstants.APIParams.itemPictures) as? [String] ?? []
    }
    
}
