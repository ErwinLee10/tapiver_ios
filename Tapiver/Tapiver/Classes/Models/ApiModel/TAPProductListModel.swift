//
//  TAPProductListModel.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/13/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPProductListModel: TAPBaseEntity {
    var productList: [TAPProductModel] = []
    
    override func parserResponse(dic: NSDictionary) {
        super.parserResponse(dic: dic)
    }
    
    override func parserResponseArray(dics: [NSDictionary]) {
        super.parserResponseArray(dics: dics)
        for dic in dics {
            let product = TAPProductModel()
            product.parserResponse(dic: dic)
            productList.append(product)
        }
    }
}
