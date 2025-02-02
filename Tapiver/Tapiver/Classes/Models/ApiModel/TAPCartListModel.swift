//
//  TAPCartListModel.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPCartListModel: TAPBaseEntity {
    var cartItemsPerSeller: [TAPCartItemModel] = []
    var coupon: TAPCouponModel?
    var finalTotalAmount: Double?
    var originalTotalAmount:Double?
    var calTotalAmount: Double {
        var total: Double = 0
        for item in cartItemsPerSeller {
            total += item.calTotalPrice
        }
        return total
    }
    
    override func parserResponse(dic: NSDictionary) {
        if let cartItemsPerSellerDic = dic.value(forKey: TAPConstants.APIParams.cartItemsPerSeller) as? [NSDictionary], cartItemsPerSellerDic.count > 0 {
            for item in cartItemsPerSellerDic {
                let cartItem = TAPCartItemModel()
                cartItem.parserResponse(dic: item)
                cartItemsPerSeller.append(cartItem)
            }
        }
        
        if let couponDic = dic.value(forKey: TAPConstants.APIParams.coupon) as? NSDictionary {
            coupon = TAPCouponModel()
            coupon?.parserResponse(dic: couponDic)
        }
        
        finalTotalAmount = dic.value(forKey: TAPConstants.APIParams.finalTotalAmount) as? Double
        originalTotalAmount = dic.value(forKey: TAPConstants.APIParams.originalTotalAmount) as? Double
    }
}

class TAPCartItemModel: TAPBaseEntity {
    var sellerId: Int?
    var sellerName: String?
    var totalPrice: Double?
    var sellerAddress: TAPAddressModel?
    var productVariations: [TAPProductVariationModel] = []
    var shippingOptions: [TAPShippingModel] = []
    var isViewLess: Bool = false
    var isViewDetail: Bool = false
    var calTotalPrice: Double {
        var price: Double = 0
        for product in productVariations {
            price += (product.finalPrice ?? 0) * Double(product.quantity ?? 0)
        }
        return price
    }
    
    override func parserResponse(dic: NSDictionary) {
        sellerId = dic.value(forKey: TAPConstants.APIParams.sellerId) as? Int
        sellerName = dic.value(forKey: TAPConstants.APIParams.sellerName) as? String
        totalPrice = dic.value(forKey: TAPConstants.APIParams.totalPrice) as? Double
        
        if let addressDic = dic.value(forKey: TAPConstants.APIParams.sellerAddress) as? NSDictionary {
            sellerAddress = TAPAddressModel()
            sellerAddress?.parserResponse(dic: addressDic)
        }
        
        if let variations = dic.value(forKey: TAPConstants.APIParams.productVariations) as? [NSDictionary], variations.count > 0 {
            for item in variations {
                let product = TAPProductVariationModel()
                product.parserResponse(dic: item)
                productVariations.append(product)
            }
        }
        
        if let shippings = dic.value(forKey: TAPConstants.APIParams.shippingOptions) as? [NSDictionary] {
            for item in shippings {
                let ship = TAPShippingModel()
                ship.parserResponse(dic: item)
                if item == shippings.first {
                    ship.isSelect = true
                }
                shippingOptions.append(ship)
            }
        }
    }
    
}

class TAPProductVariationModel: TAPBaseEntity {
    var id: Int?
    var name: String?
    var brand: String?
    var originalPrice: Double?
    var salePrice: Double?
    var finalPrice: Double?
    var quantity: Int?
    var availableStock: Int?
    var pictureUrl: String?
    var size: String?
    var colorHexCode: String?
    var colorName: String?
    var categoryId: Int?
    var categoryName: String?
    var onSale: Bool?
    var numberQuantity: Int?
    
    override func parserResponse(dic: NSDictionary) {
        id = dic.value(forKey: TAPConstants.APIParams.id) as? Int
        name = dic.value(forKey: TAPConstants.APIParams.name) as? String
        brand = dic.value(forKey: TAPConstants.APIParams.brand) as? String
        originalPrice = dic.value(forKey: TAPConstants.APIParams.originalPrice) as? Double
        salePrice = dic.value(forKey: TAPConstants.APIParams.salePrice) as? Double
        finalPrice = dic.value(forKey: TAPConstants.APIParams.finalPrice) as? Double
        quantity = dic.value(forKey: TAPConstants.APIParams.quantity) as? Int
        availableStock = dic.value(forKey: TAPConstants.APIParams.availableStock) as? Int
        pictureUrl = dic.value(forKey: TAPConstants.APIParams.pictureUrl) as? String
        size = dic.value(forKey: TAPConstants.APIParams.size) as? String
        colorHexCode = dic.value(forKey: TAPConstants.APIParams.colorHexCode) as? String
        colorName = dic.value(forKey: TAPConstants.APIParams.colorName) as? String
        categoryId = dic.value(forKey: TAPConstants.APIParams.categoryId) as? Int
        categoryName = dic.value(forKey: TAPConstants.APIParams.categoryName) as? String
        onSale = dic.value(forKey: TAPConstants.APIParams.onSale) as? Bool
    }
}

class TAPCouponModel: TAPBaseEntity {
    var name: String?
    var totalSaving: Double?
    var percentage: Int?
    var isPercentageDiscount: Bool?
    var message: String?
    var id: Int?
    
    override func parserResponse(dic: NSDictionary) {
        name = dic.value(forKey: TAPConstants.APIParams.name) as? String
        totalSaving = dic.value(forKey: TAPConstants.APIParams.totalSaving) as? Double
        percentage = dic.value(forKey: TAPConstants.APIParams.percentage) as? Int
        isPercentageDiscount = dic.value(forKey: TAPConstants.APIParams.isPercentageDiscount) as? Bool
        message = dic.value(forKey: TAPConstants.APIParams.message) as? String
        id = dic.value(forKey: TAPConstants.APIParams.id) as? intmax_t
    }
}
class TAPShippingModel: TAPBaseEntity {
    var idShip: Int?
    var provider: String?
    var type: String?
    var price: Double?
    var isPickup: Bool = false
    var isfreeShipping: Bool = false
    var additionalInfor: TAPAdditionalInformation?
    var isSelect: Bool = false
    
    override func parserResponse(dic: NSDictionary) {
        idShip = dic.value(forKey: TAPConstants.APIParams.id) as? Int
        provider = dic.value(forKey: TAPConstants.APIParams.provid) as? String
        type = dic.value(forKey: TAPConstants.APIParams.type) as? String
        if !(dic.value(forKey: TAPConstants.APIParams.price) is NSNull) {
            price = dic.value(forKey: TAPConstants.APIParams.price) as? Double
        }
        isPickup = dic.value(forKey: TAPConstants.APIParams.isPickup) as! Bool
        isfreeShipping  = dic.value(forKey: TAPConstants.APIParams.freeShipping) as! Bool
        additionalInfor = TAPAdditionalInformation()
        additionalInfor?.parserResponse(dic: dic.value(forKey: TAPConstants.APIParams.additionalInformation) as! NSDictionary) 
    }
}
class TAPAdditionalInformation: TAPBaseEntity {
    var time: String?
    var cashbackPercentage: Float?
    var cashbackEarned: Double?
    override func parserResponse(dic: NSDictionary) {
        time = dic.value(forKey: TAPConstants.APIParams.time) as? String
        if !(dic.value(forKey: TAPConstants.APIParams.cashbackPercent) is NSNull) {
            cashbackPercentage  = dic.value(forKey: TAPConstants.APIParams.cashbackPercent) as? Float
        }
        if !(dic.value(forKey: TAPConstants.APIParams.cashbackEarn) is NSNull) {
            cashbackEarned  = dic.value(forKey: TAPConstants.APIParams.cashbackEarn) as? Double
        }
    }
}
