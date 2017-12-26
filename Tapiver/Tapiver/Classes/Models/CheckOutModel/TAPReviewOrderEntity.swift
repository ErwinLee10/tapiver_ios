//
//  TAPReviewOrderEntity.swift
//  Tapiver
//
//  Created by HungVT on 12/22/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPReviewOrderEntity: TAPBaseEntity {
    var address: TAPAddressModel?
    var addressBilling: TAPAddressModel?
    var cardList: TAPCartListModel?
    var isViewAddLess: Bool = false
    var isViewDetail: Bool = false
}
