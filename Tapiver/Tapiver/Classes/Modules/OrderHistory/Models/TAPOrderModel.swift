//
//  TAPOrderModel.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/21/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPOrderModel: TAPBaseEntity {
    var isCollapsed: Bool = true
    var id: Int64?
    var orderDate: Double?
    var totalAmount: Int?
    var orderStatus: String?
    var displayStatus: String?
    var shippingType: String?
//    var shippingProvider: String?
    var isPickup: Bool = false
    var shippingAddress: TAPAddressModel?
//    var billingAddress: TAPAddressModel?
    var shippingCost: Int?
    var cashback: Int?
//    var sellerId: Int?
//    var sellerName: String?
//    var sellerPicture: String?
    var sellerAddress: TAPAddressModel?
    var items: [TAPOrderItemModel] = []
    
    override func parserResponse(dic: NSDictionary) {
        id = dic.value(forKey: TAPConstants.APIParams.id) as? Int64
        orderDate = dic.value(forKey: TAPConstants.APIParams.orderDate) as? Double
        totalAmount = dic.value(forKey: TAPConstants.APIParams.totalAmount) as? Int
        orderStatus = dic.value(forKey: TAPConstants.APIParams.orderStatus) as? String
        displayStatus = self.covertOrderStatusToDisplayStatus()
        shippingType = dic.value(forKey: TAPConstants.APIParams.shippingType) as? String
        isPickup = dic.value(forKey: TAPConstants.APIParams.isPickup) as? Bool ?? false
        shippingCost = dic.value(forKey: TAPConstants.APIParams.shippingCost) as? Int
        cashback = dic.value(forKey: TAPConstants.APIParams.cashback) as? Int
        
        if let shippingAdd = dic.value(forKey: TAPConstants.APIParams.shippingAddress) as? NSDictionary {
            shippingAddress = TAPAddressModel()
            shippingAddress?.parserResponse(dic: shippingAdd)
        }
        
        if let sellerAdd = dic.value(forKey: TAPConstants.APIParams.sellerAddress) as? NSDictionary {
            sellerAddress = TAPAddressModel()
            sellerAddress?.parserResponse(dic: sellerAdd)
        }
        
        if let itemArr = dic.value(forKey: TAPConstants.APIParams.items) as? [NSDictionary], itemArr.count > 0 {
            for item in itemArr {
                let itemModel = TAPOrderItemModel()
                itemModel.parserResponse(dic: item)
                items.append(itemModel)
            }
        }
        
    }
    
    private func covertOrderStatusToDisplayStatus() -> String? {
        guard let status = orderStatus else {
            return nil
        }
        let lowercasedStatus = status.lowercased()
        switch lowercasedStatus {
        case "shipping sending":
            return "Processing"
        case "pickup pending":
            return "Processing"
        case "ready for pick up":
            return "Ready for Pick Up"
        case "ready to ship":
            return "Processing"
        case "picked up":
            return "Completed"
        case "shipped":
            return "Shipped"
        case "investigation":
            return "Investigation"
        case "request partial refund":
            return "Investigation"
        case "request full refund":
            return "Investigation"
        case "completed by exchange":
            return "Completed"
        case "completed by partial refund":
            return "Partially Refunded"
        case "completed by full refund":
            return "Fully Refunded"
        case "completed by rejecting claim":
            return "Completed"
        case "cancelled":
            return "Fully Refunded"
        case "completed":
            return "Completed"
        default:
            return nil
        }
    }
    
}
