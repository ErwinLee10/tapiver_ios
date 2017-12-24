//
//  TAPAddressModel.swift
//  Tapiver
//
//  Created by HungHN on 12/6/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPAddressModel: TAPBaseEntity {
    
    var id: Int?
    var streetName: String?
    var buildingName: String?
    var floor: String?
    var unitNumber: String?
    var postalCode: String?
    var contact: String?
    var shortDisplayAddress: String?
    var landmark: TAPLandmarkModel?
    var formattedAddress: String?
    var formattedFloorAndUnitAddres: String?

    override func parserResponse(dic: NSDictionary) {
        id = dic.value(forKey: "id") as? Int
        if id == nil   {
            if let index = dic.value(forKey: "id") as? String {
                id = Int(index)
            }
        }
        streetName = dic.value(forKey: "streetName") as? String
        buildingName = dic.value(forKey: "buildingName") as? String
        floor = dic.value(forKey: "floor") as? String
        unitNumber = dic.value(forKey: "unitNumber") as? String
        postalCode = dic.value(forKey: "postalCode") as? String
        contact = dic.value(forKey: "contact") as? String
        shortDisplayAddress = dic.value(forKey: "shortDisplayAddress") as? String
        formattedAddress = dic.value(forKey: "formattedAddress") as? String
        formattedFloorAndUnitAddres = dic.value(forKey: "formattedFloorAndUnitAddres") as? String
        guard let dataLandMark = dic.value(forKey: "landmark") as? NSDictionary else {
            return
        }
        landmark = TAPLandmarkModel()
        landmark?.parserResponse(dic:dataLandMark )
    }
}

class TAPLandmarkModel: TAPBaseEntity {
    var id: Int?
    var name: String?
    var picture: String?
    
    override func parserResponse(dic: NSDictionary) {
        id = dic.value(forKey: "id") as? Int
        name = dic.value(forKey: "name") as? String
        picture = dic.value(forKey: "picture") as? String
    }
}

/*
"id": 3,
"streetName": "238 Haji Lane",
"buildingName": "Haji Lane",
"floor": "",
"unitNumber": "",
"postalCode": "189222",
"contact": "+6567633612",
"shortDisplayAddress": "Haji Lane",
"landmark": {
    "id": 1,
    "name": "Haji Lane",
    "picture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/tapiver/landmark/Haji+Lane.jpg"
},
"formattedAddress": "238 Haji Lane",
"formattedFloorAndUnitAddres": ""
*/
