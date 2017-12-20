//
//  TAPFeedModel.swift
//  Tapiver
//
//  Created by HungHN on 12/6/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPFeedModel: TAPBaseEntity  {
    
    var idItem: Int?
    var sellerId: Int?
    var sellerName: String?
    var sellerAddress: TAPAddressModel?
    var sellerPicture: String?
    var sellerCoverPicture: String?
    var sellerTotalFollower: Int?
    var isFollowedByThisUser: Bool = false
    var products: [TAPProductModel]? = []
    
    override func parserResponse(dic: NSDictionary) {
        idItem = dic.value(forKey: "id") as? Int
        sellerId = dic.value(forKey: "sellerId") as? Int
        sellerName = dic.value(forKey: "sellerName") as? String
        sellerPicture = dic.value(forKey: "sellerPicture") as? String
        sellerCoverPicture = dic.value(forKey: "sellerCoverPicture") as? String
        sellerTotalFollower = dic.value(forKey: "sellerTotalFollower") as? Int
        isFollowedByThisUser = dic.value(forKey: "isFollowedByThisUser") as? Bool ?? false
        guard let dataSellerAddress = dic.value(forKey: "sellerAddress") as? NSDictionary else {
            return
        }
        sellerAddress = TAPAddressModel()
        sellerAddress?.parserResponse(dic:dataSellerAddress)
        
        guard let dataProducts = dic.value(forKey: "products") as? [NSDictionary] else {
            return
        }
        for data in dataProducts {
            let model = TAPProductModel()
            model.parserResponse(dic:data)
            products?.append(model)
        }
    }
}

