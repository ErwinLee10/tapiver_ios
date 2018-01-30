//
//  TAPProductDetailModel.swift
//  Tapiver
//
//  Created by admin on 12/21/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation

class TAPProductDetailModel: TAPBaseEntity {
    
    var name: String?
    var sellerName: String?
    var sellerId: String?
    var sellerPicture: String?
    var sellerTotalFollower: Int?
    var sellerAddress: TAPAddressModel?
    var openingHours: [String]?
    var likes: Int = 0
    var isLikedByThisUser: Bool = false
    var isSellerFollowedByUser: Bool = false
    var description1: String?
    var brand: String?
    var shippingsCost: TAPListShippingCostModel?
//    var latestReviews
    var variations: TAPListVariationsModel?
    var categoryId: Int?
    var categoryName: String?
    
    
    
    
    override func parserResponse(dic: NSDictionary) {
        name = dic.value(forKey: TAPConstants.APIParams.name) as? String
        sellerName = dic.value(forKey: TAPConstants.APIParams.sellerName) as? String
        sellerId = dic.value(forKey: TAPConstants.APIParams.sellerId) as? String
        sellerPicture = dic.value(forKey: TAPConstants.APIParams.sellerPicture) as? String
        sellerTotalFollower = dic.value(forKey: TAPConstants.APIParams.sellerTotalFollower) as? Int
        if let sellerAddressDic = dic.value(forKey: TAPConstants.APIParams.sellerAddress) as? NSDictionary {
            sellerAddress = TAPAddressModel()
            sellerAddress?.parserResponse(dic: sellerAddressDic)
        }
        var openingHoursArray: [String] = []
        for (key, value) in dic.value(forKey:TAPConstants.APIParams.openingHours) as! NSDictionary {
            let array = value as! [String]
            openingHoursArray.append(array[0])
        }
        openingHours = openingHoursArray
        likes = dic.value(forKey: TAPConstants.APIParams.likes) as? Int ?? 0
        isLikedByThisUser = dic.value(forKey: TAPConstants.APIParams.isLikedByThisUser) as? Bool ?? false
        isSellerFollowedByUser = dic.value(forKey: TAPConstants.APIParams.isSellerFollowedByUser) as? Bool ?? false
        description1 = dic.value(forKey: TAPConstants.APIParams.description) as? String
        brand = dic.value(forKey: TAPConstants.APIParams.brand) as? String
        if let shippingsCostDic = dic.value(forKey: TAPConstants.APIParams.shippingsCost) as? [NSDictionary] {
            shippingsCost = TAPListShippingCostModel()
            shippingsCost?.parserResponseArray(dics: shippingsCostDic)
        }
        if let dataVariationsOverview = dic.value(forKey: TAPConstants.APIParams.variations) as? [NSDictionary] {
            variations = TAPListVariationsModel()
            variations?.parserResponseArray(dics: dataVariationsOverview)
        }
        categoryId = dic.value(forKey: TAPConstants.APIParams.categoryId) as? Int ?? 0
        categoryName = dic.value(forKey: TAPConstants.APIParams.categoryName) as? String
    }
}

class TAPListShippingCostModel: TAPBaseEntity {
    var listShipping: [TAPShippingCostModel]? = []
    override func parserResponseArray(dics: [NSDictionary]) {
        super.parserResponseArray(dics: dics)
        for dict in dics {
            let item =  TAPShippingCostModel()
            item.parserResponse(dic: dict)
            listShipping?.append(item)
        }
    }
}

class TAPShippingCostModel: TAPBaseEntity {
    var provider: String?
    var type: String?
    var price: Double?
    var isPickup: Bool?
    var time: String?
    var cashbackPercentage: Int?
    var freeShippingThreshold: Int?
    
    override func parserResponse(dic: NSDictionary) {
        provider = dic.value(forKey: TAPConstants.APIParams.provider) as? String
        type = dic.value(forKey: TAPConstants.APIParams.type) as? String
        price = dic.value(forKey: TAPConstants.APIParams.price) as? Double ?? 0
        isPickup = dic.value(forKey: TAPConstants.APIParams.isPickup) as? Bool ?? false
        if let additionalInformation = dic.value(forKey: TAPConstants.APIParams.additionalInformation) as? NSDictionary {
            time = additionalInformation.value(forKey: TAPConstants.APIParams.time) as? String ?? ""
            cashbackPercentage = additionalInformation.value(forKey: TAPConstants.APIParams.cashbackPercentage) as? Int ?? 0
            freeShippingThreshold = additionalInformation.value(forKey: TAPConstants.APIParams.freeShippingThreshold) as? Int ?? 0
        }
        
    }
}

class TAPListVariationsModel: TAPBaseEntity {
    var listVariations: [TAPVariationsOverviewModel]? = []
    var listColor: [String] = []
    override func parserResponseArray(dics: [NSDictionary]) {
        super.parserResponseArray(dics: dics)
        for dict in dics {
            let item =  TAPVariationsOverviewModel()
            item.parserResponse(dic: dict)
            listVariations?.append(item)
            if ( !listColor.contains(item.colorHexCode!) )  {
                listColor.append(item.colorHexCode!)
            }
        }
    }
}
