//
//  TAPSubShippingEntity.swift
//  Tapiver
//
//  Created by HungVT on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPSubShippingEntity: TAPBaseEntity {
    var titleSub: String?
    var cost: String?
    var isSelect: Bool = false
    var cashBack: Int = 0
    
    init(title: String, cost: String, isSelect: Bool, cashBack: Int) {
        super.init()
        self.titleSub = title
        self.cost = cost
        self.isSelect = isSelect
        self.cashBack = cashBack
    }
}
class TAPListSubShippingEntity: TAPBaseEntity {
    var listData: [TAPSubShippingEntity]? = []
    
    override init() {
        super.init()
        let list = ["Express Ship","Standar Ship","Store Ship"]
        let cost = ["S$18.5","S$8.5","Free"]
        for i in 0..<list.count {
            let obj = TAPSubShippingEntity.init(title: list[i], cost: cost[i], isSelect: false, cashBack: 0)
            listData?.append(obj)
        }
    }
}
