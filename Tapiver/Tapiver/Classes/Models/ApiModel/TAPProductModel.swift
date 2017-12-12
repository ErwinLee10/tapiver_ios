//
//  TAPProductModel.swift
//  Tapiver
//
//  Created by HungHN on 12/6/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPProductModel: TAPBaseEntity {
    var id: Int?
    var name: String?
    var likes: Int = 0
    var isLikedByThisUser: Bool = false
    var brand: String?
    var variationsOverview: TAPVariationsOverviewModel?
    
    override func parserResponse(dic: NSDictionary) {
        id = dic.value(forKey: "id") as? Int
        name = dic.value(forKey: "name") as? String
        likes = dic.value(forKey: "likes") as? Int ?? 0
        isLikedByThisUser = dic.value(forKey: "isLikedByThisUser") as? Bool ?? false
        guard let dataVariationsOverview = dic.value(forKey: "variationsOverview") as? [NSDictionary] else {
            return
        }
        variationsOverview = TAPVariationsOverviewModel()
        variationsOverview?.parserResponseArray(dics: dataVariationsOverview)
    }
}

class TAPVariationsOverviewModel: TAPBaseEntity {
    var id: Int?
    var size: String?
    var colorHexCode: String?
    var colorName: String?
    var pictures: [String]? = []
    var labels: [String]? = []
    var originalPrice: Int?
    var salePrice: Int?
    var stock: Int?
    
    override func parserResponse(dic: NSDictionary) {
        id = dic.value(forKey: "id") as? Int
        size = dic.value(forKey: "size") as? String
        colorHexCode = dic.value(forKey: "colorHexCode") as? String
        colorName = dic.value(forKey: "colorName") as? String
        pictures = dic.value(forKey: "pictures") as? [String]
        labels = dic.value(forKey: "labels") as? [String]
        originalPrice = dic.value(forKey: "originalPrice") as? Int
        salePrice = dic.value(forKey: "salePrice") as? Int
        stock = dic.value(forKey: "stock") as? Int
    }
    
    override func parserResponseArray(dics: [NSDictionary]) {
        parserResponse(dic: dics[0])
    }
}

/*
{
    "id": "373",
    "name": "testing pixel",
    "likes": 0,
    "isLikedByThisUser": false,
    "brand": "",
    "variationsOverview": [
    {
    "id": 1233,
    "size": null,
    "colorHexCode": "#000000",
    "colorName": "",
    "pictures": [
    "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/c53bbf81-38a8-4407-8ced-21569e85315f.jpg",
    "https://s3-ap-southeast-1.amazonaws.com/tapiver/supclothing/PRODUCT/dc4d496c-6fb7-4645-b432-3f7e626f44d1.jpg"
    ],
    "labels": [
    "NEW",
    "FREE_SHIPPING"
    ],
    "originalPrice": 12,
    "salePrice": null,
    "stock": 123
    }
    ]
}
*/
