//
//  TAPContant.swift
//  Tapiver
//
//  Created by HungHN on 11/30/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation

let API_URL = "https://dev-backend.tapiver.com"

struct TAPConstants {
    // MARK: Path -
    struct APIPath {
        static let getProducts              = "/api/v1/products"
        static let overview                 = "/api/v1/s/overview"
    }
    
    // MARK: Params -
    struct APIParams {
        static let page                     = "page"
        static let userId                   = "userId"
        static let categoryId               = "categoryId"
        static let landmarkId               = "landmarkId"
        static let q                        = "q"
        static let minPrice                 = "minPrice"
        static let maxPrice                 = "maxPrice"
        static let sellerId                 = "sellerId"
        static let hasDeal                  = "hasDeal"
        static let sortBy                   = "sortBy"
        static let isHot                    = "isHot"
        static let isFeatured               = "isFeatured"
        static let id                       = "id"
        static let name                     = "name"
        static let sellerName               = "sellerName"
        static let sellerPicture            = "sellerPicture"
        static let sellerCoverPicture       = "sellerCoverPicture"
        static let sellerTotalFollower      = "sellerTotalFollower"
        static let sellerAddress            = "sellerAddress"
        static let streetName               = "streetName"
        static let buildingName             = "buildingName"
        static let floor                    = "floor"
        static let unitNumber               = "unitNumber"
        static let postalCode               = "postalCode"
        static let contact                  = "contact"
        static let shortDisplayAddress      = "shortDisplayAddress"
        static let landmark                 = "landmark"
        static let picture                  = "picture"
        static let formattedAddress         = "formattedAddress"
        static let formattedFloorAndUnitAddres = "formattedFloorAndUnitAddres"
        static let isLikedByThisUser        = "isLikedByThisUser"
        static let likes                    = "likes"
        static let brand                    = "brand"
        static let variationsOverview       = "variationsOverview"
        static let colorHexCode             = "colorHexCode"
        static let size                     = "size"
        static let colorName                = "colorName"
        static let pictures                 = "pictures"
        static let labels                   = "labels"
        static let originalPrice            = "originalPrice"
        static let salePrice                = "salePrice"
        static let finalPrice               = "finalPrice"
        static let stock                    = "stock"
        static let hasProducts              = "hasProducts"
        static let cartItemsPerSeller       = "cartItemsPerSeller"
        static let totalPrice               = "totalPrice"
        static let productVariations        = "productVariations"
        static let quantity                 = "quantity"
        static let availableStock           = "availableStock"
        static let pictureUrl               = "pictureUrl"
        static let categoryName             = "categoryName"
        static let onSale                   = "onSale"
        static let coupon                   = "coupon"
        static let finalTotalAmount         = "finalTotalAmount"
        static let originalTotalAmount      = "originalTotalAmount"
        static let totalSaving              = "totalSaving"
        static let percentage               = "percentage"
        static let message                  = "message"
        static let isPercentageDiscount     = "isPercentageDiscount"
        static let orderDate     = "orderDate"
        static let totalAmount     = "totalAmount"
        static let orderStatus     = "orderStatus"
        static let shippingType     = "shippingType"
        static let shippingProvider     = "shippingProvider"
        static let isPickup     = "isPickup"
        static let shippingAddress     = "shippingAddress"
        static let billingAddress     = "billingAddress"
        static let shippingCost     = "shippingCost"
        static let cashback     = "cashback"
        static let items     = "items"
        static let itemId     = "itemId"
        static let itemName     = "itemName"
        static let discountPercentage     = "discountPercentage"
        static let itemPictures     = "itemPictures"
        
        
    }
}

