//
//  TAPPayMentMethodView.swift
//  Tapiver
//
//  Created by Hung vu on 12/23/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import Stripe
import IQKeyboardManagerSwift

enum CardType: Int {
    case credit = 0
    case paypal = 1
    case pickup = 2
}

class TAPPayMentMethodView: UIViewController {
    @IBOutlet weak var headerView: TAPHeaderView!
    @IBOutlet weak var sView: UIView!
    @IBOutlet weak var tfCardNumber: UITextField!
    @IBOutlet weak var tfCsv: UITextField!
    @IBOutlet weak var tfExpDate: UITextField!
    @IBOutlet weak var btPlaceOrder: UIButton!
    @IBOutlet var listBtCard: [UIControl]!
    private var cardType: CardType = .credit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIB()
        
    }
    private func initIB() {
        self.headerView.delegate = self
        IQKeyboardManager.sharedManager().enable = true
    }
    
    private func createCardType() {
        for item in listBtCard {
            item.addTarget(self, action: Selector(("actionCardType:")), for: .touchUpInside)
            let index = self.listBtCard?.index(of: item)
            if index == self.cardType.rawValue {
                item.isEnabled = true
            }else {
                item.isEnabled = false
            }
        }
    }
    func actionCardType(sender:UIButton) {
        
    }
    @IBAction func acPlaceOrder(_ sender: Any) {
        if tfExpDate.text?.isEmpty == true {
            return
        }
        let tripCardParams = STPCardParams()
        let expireDate = self.tfExpDate.text?.components(separatedBy: "/")
        if expireDate!.count < 2 {
            return
        }
        if expireDate!.count < 3 {
            return
        }
        let expMonth = UInt(Int(expireDate![1])!)
        let expYear = UInt(Int(expireDate![0])!)
        let expDay = UInt(Int(expireDate![2])!)
        
        tripCardParams.number = tfCardNumber.text
        tripCardParams.cvc = tfCsv.text
        tripCardParams.expMonth = expMonth
        tripCardParams.expYear = expYear
        // 2
        if (STPCardValidator.validationState(forCard: tripCardParams) == .valid) {
            // 3
            STPAPIClient.shared().createToken(withCard: tripCardParams, completion: { (token, error) in
                // 4
                if error != nil {
                    return
                }else {
                    
                }
                
            })
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TAPPayMentMethodView: TAPHeaderViewDelegate {
    func headerViewDidTouchBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TAPPayMentMethodView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isEqual(self.tfExpDate) {
            let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            if (result.length() >= 11) {
                return false
            }
            if result.length() == 5 || result.length() == 8 || result.length() == 11 {
                textField.text?.append("/")
            }
        }
        
        return true
    }
}
