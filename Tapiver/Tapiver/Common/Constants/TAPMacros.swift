//
//  TAPMacros.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/12/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

var SCREEN_SIZE: CGSize {
    get {
        return UIScreen.main.bounds.size
    }
}

var SCREEN_WIDTH: CGFloat {
    get {
        return UIScreen.main.bounds.size.width
    }
}

var SCREEN_HEIGHT: CGFloat {
    get {
        return UIScreen.main.bounds.size.height
    }
}

var WINDOW: UIWindow? {
    get {
        return UIApplication.shared.delegate?.window ?? nil
    }
}

