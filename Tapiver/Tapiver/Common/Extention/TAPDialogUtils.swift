//
//  TAPDialogUtils.swift
//  Tapiver
//
//  Created by hunghoang on 12/2/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

typealias AlertActionHandler = (() -> Void)?;

class TAPDialogUtils: NSObject {
    
    static let shareInstance = TAPDialogUtils()
    override init() {
    }
    
    func showAlerMessage(title: String?, message: String?, positive:String?, positiveHandler: AlertActionHandler, negative:String?, negativeHandler: AlertActionHandler, vc:UIViewController) -> Void {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        if !(positive?.isEmpty ?? true) {
            let positiveAction = UIAlertAction.init(title: positive, style: UIAlertActionStyle.default) { (alertAction) in
                positiveHandler?()
            }
            alert.addAction(positiveAction)
        }
        if !(negative?.isEmpty ?? true) {
            let negativeAction = UIAlertAction.init(title: negative, style: UIAlertActionStyle.cancel) { (alertAction) in
                negativeHandler?()
            }
            alert.addAction(negativeAction)
        }
        vc.present(alert, animated: true, completion: nil)
    }
    
    func showAlertMessageOneButton(title: String?, message: String?, positive:String?, positiveHandler:AlertActionHandler, vc:UIViewController) -> Void {
        self.showAlerMessage(title: title, message: message, positive: positive, positiveHandler: positiveHandler, negative: nil, negativeHandler: nil, vc: vc)
    }
}
