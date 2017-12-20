//
//  TAPProfileModel.swift
//  Tapiver
//
//  Created by admin on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation

class TAPProfileModel: TAPBaseEntity, NSCoding {
    var cashbacks: Int?
    var email: String?
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var address: TAPListProfileAddress?
    
    override func parserResponse(dic:NSDictionary) -> Void {
        self.cashbacks = dic.value(forKey: "cashbacks") as? Int ?? 0
        self.email = dic.value(forKey: "email") as? String ?? ""
        self.firstName = dic.value(forKey: "firstName") as? String ?? ""
        self.lastName = dic.value(forKey: "lastName") as? String ?? ""
        self.phoneNumber = dic.value(forKey: "phoneNumber") as? String ?? ""
    }
    
    override init() {
        self.cashbacks = 0
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.phoneNumber = ""
        self.address = nil
    }
    
    required init(coder decoder: NSCoder) {
        self.cashbacks = decoder.decodeObject(forKey: "cashbacks") as? Int ?? 0
        self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
        self.firstName = decoder.decodeObject(forKey: "firstName") as? String ?? ""
        self.lastName = decoder.decodeObject(forKey: "lastName") as? String ?? ""
        self.phoneNumber = decoder.decodeObject(forKey: "phoneNumber") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(cashbacks, forKey: "cashbacks")
        coder.encode(email, forKey: "email")
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(phoneNumber, forKey: "phoneNumber")
    }
    
    func addAddress(address: TAPListProfileAddress) {
        self.address = address
    }
}
/*
 {
 "firstName": "Erwin",
 "lastName": "Lee ",
 "email": "tommy_fong.lee@hotmail.com",
 "phoneNumber": null,
 "cashbacks": 0
 }
 */

class TAPListProfileAddress: TAPBaseEntity {
    var listProfileAddress: [TAPProfileAddressModel]? = []
    override func parserResponseArray(dics: [NSDictionary]) {
        super.parserResponseArray(dics: dics)
        for dict in dics {
            let item =  TAPProfileAddressModel()
            item.parserResponse(dic: dict)
            listProfileAddress?.append(item)
        }
    }
}

class TAPProfileAddressModel: TAPBaseEntity {
    var id: Int?
    var streetName: String?
    var floor: String?
    var unitNumber: String?
    var postalCode: String?
    var alias: String?
    var contact: String?
    
    override init() {
        self.id = 0
        self.streetName = ""
        self.floor = ""
        self.unitNumber = ""
        self.postalCode = ""
        self.alias = ""
        self.contact = ""
    }
    
//    override func parserResponseArray(dics: [NSDictionary]) {
//        for dic in dics {
//            let model = TAPProfileAddressModel()
//            model.parserResponse(dic: dic)
//        }
//    }
    
    override func parserResponse(dic:NSDictionary) -> Void {
        let id = dic.value(forKey: "id") as? String ?? "0"
        self.id = Int(id)
        self.streetName = dic.value(forKey: "streetName") as? String ?? ""
        self.floor = dic.value(forKey: "floor") as? String ?? ""
        self.unitNumber = dic.value(forKey: "unitNumber") as? String ?? ""
        self.postalCode = dic.value(forKey: "postalCode") as? String ?? ""
        self.alias = dic.value(forKey: "alias") as? String ?? ""
        self.contact = dic.value(forKey: "contact") as? String ?? ""
    }
}

/*
 {
 "id": "101",
 "streetName": "testing",
 "floor": "12626",
 "unitNumber": "5552",
 "postalCode": "4161626",
 "alias": "testing",
 "contact": "611626"
 }
 */
