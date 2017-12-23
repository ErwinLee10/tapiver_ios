//
//  UIAlertControllerExtension.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/23/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addAction(title: String?, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) {
        let alertAction = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(alertAction)
    }
}
