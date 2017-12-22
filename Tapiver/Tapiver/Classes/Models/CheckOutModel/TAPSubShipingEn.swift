//
//  TAPSubShipingEn.swift
//  Tapiver
//
//  Created by Hung vu on 12/21/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
enum SubShipingType:Int {
    case header
    case content
}
class TAPSubShipingEn: TAPBaseEntity {
    var typeSubShipping: SubShipingType?
    var shiping = TAPShippingModel()
}
