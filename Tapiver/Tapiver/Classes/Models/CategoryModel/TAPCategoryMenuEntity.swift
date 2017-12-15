//
//  TAPCategoryMenuEntity.swift
//  Tapiver
//
//  Created by HungVT on 12/14/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPListCategoryMenu: TAPBaseEntity {
    var listCategory: [TAPCategoryMenuEntity]? = []
    override func parserResponseArray(dics: [NSDictionary]) {
        super.parserResponseArray(dics: dics)
        for dict in dics {
            let item =  TAPCategoryMenuEntity()
            item.parserResponse(dic: dict)
            listCategory?.append(item)
        }
    }
    
}

class TAPCategoryMenuEntity: TAPBaseEntity {
    var idMenu: Int?
    var imgNormal: UIImage?
    var imgSelected: UIImage?
    var name: String?
    var isSelected: Bool? = false
    var listSub: [TAPCategoryMenuEntity]? = []
    var isMenu0: Bool? = true
    
    
    
    override func parserResponse(dic: NSDictionary ) {
        isSelected = false
        self.idMenu = dic.value(forKey: "id") as? Int
        self.name = dic.value(forKey: "name") as? String
        if self.isMenu0 == true {
            
            self.imgSelected = UIImage.init(named: self.name!)
            let imgN = self.name! + "_normal"
            self.imgNormal = UIImage.init(named: imgN)
        }

        guard let dataCategorys = dic.value(forKey: "sub") as? [NSDictionary] else {
            return
        }
        
        for data in dataCategorys {
            let model = TAPCategoryMenuEntity()
            model.isMenu0 = false
            model.parserResponse(dic:data )
            listSub?.append(model)
        }
        
    }
}
