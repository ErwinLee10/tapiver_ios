//
//  TAPHelpers.swift
//  Tapiver
//
//  Created by HungHN on 12/5/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

// Define delegate
func appDelegate() -> AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
}

func API_PATH(path: String) -> String {
    return API_URL + path
}
