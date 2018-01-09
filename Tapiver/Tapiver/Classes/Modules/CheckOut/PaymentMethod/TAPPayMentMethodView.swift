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
    @IBOutlet weak var btPlaceOrder: UIButton!
	@IBOutlet weak var cardContainView: UIView!
	let cardField = STPPaymentCardTextField()
//    private var cardType: CardType = .credit
    public var reviewObj: TAPReviewOrderEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIB()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		cardField.frame = CGRect(x: 0, y: 0, width: cardContainView.frame.width, height: cardContainView.frame.height)
	}
	
    private func initIB() {
        self.headerView.delegate = self
		cardField.delegate = self
		cardContainView.addSubview(cardField)
    }
    
//    private func createCardType() {
//        for item in listBtCard {
//            item.addTarget(self, action: Selector(("actionCardType:")), for: .touchUpInside)
//            let index = self.listBtCard?.index(of: item)
//            if index == self.cardType.rawValue {
//                item.isEnabled = true
//            }else {
//                item.isEnabled = false
//            }
//        }
//    }
    func actionCardType(sender:UIButton) {
        
    }
    @IBAction func acPlaceOrder(_ sender: Any) {
        getStripeToken()
        
    }
    private func getStripeToken() {

//        let tripCardParams = STPCardParams()
//        tripCardParams.number = cardField.cardNumber
//        tripCardParams.cvc = cardField.cvc
//        tripCardParams.expMonth = cardField.expirationMonth
//        tripCardParams.expYear = cardField.expirationYear
		
		print(STPAPIClient.shared().publishableKey)
		print(cardField.cardParams)
        if (STPCardValidator.validationState(forCard: cardField.cardParams) == .valid) {
            TAPGlobal.shared.showLoading()
            STPAPIClient.shared().createToken(withCard: cardField.cardParams, completion: { [weak self] (token, error) in
                TAPGlobal.shared.dismissLoading()
                if error != nil {
                    print("tokenError = \(error?.localizedDescription ?? "")")
                    TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "\(error?.localizedDescription ?? "")", positive: "OK", positiveHandler: nil, vc: self!)
                    return
                } else {
                    print("token = \(token?.tokenId ?? "")")
                    self?.callApi(tokenStripe: token?.tokenId ?? "")
                }
                
            })
        }else {
            print("error card")
        }
        
    }
//    private func cardName() -> String {
//        switch self.cardType {
//        case .credit:
//            return "Credit/Debit"
//        case .paypal:
//            return "Paypal"
//        case .pickup:
//            return "Pickup"
//        }
//    }
    private func callApi(tokenStripe: String) {
        let params = createParams(token:tokenStripe)
        TAPGlobal.shared.showLoading()
        var apiPath = ""
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/checkout"
        }else {
            apiPath = TAPConstants.APIPath.overview
        }
		
        TAPGlobal.shared.showLoading()
		TAPWebservice.shareInstance.sendPOSTRequest(path: API_PATH(path: apiPath), params: params) { (check) in
			TAPGlobal.shared.dismissLoading()
			if check == false {
				TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
			}
		}
//        TAPWebservice.shareInstance.sendPOSTRequest(path: API_PATH(path: apiPath), params: params as NSDictionary, headers: header as NSDictionary, responseObjectClass: TAPBaseEntity()) {[weak self] (success, obj) in
//            TAPGlobal.shared.dismissLoading()
//            if success {
//
//            }
//            else {
//                guard let weakSelf = self else { return }
//                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: weakSelf)
//            }
//        }
    }
	private func createParams(token: String) -> NSDictionary {
        let total = reviewObj?.cardList?.originalTotalAmount ?? 0
        let addShipping = reviewObj?.address?.id ?? 0
        
        let totalAmountIncludeShipping = Double(total) + getIdParams().disCount
        let dict = getIdParams().orderPerSellers
        
//        let subParam = ["stripeToken" : token ,
//                                        "totalAmountWithoutShipping": total,
//                                        "shippingAddressId" : addShipping,
//                                        "billingAddressId"  : reviewObj?.addressBilling?.id ?? addShipping,
//										"couponName"        : reviewObj?.cardList?.coupon?.name!,
//                                        "totalAmountIncludeShipping": totalAmountIncludeShipping,
//                                        "orderPerSellers": dict
//			] as [String : Any]
		let param = NSMutableDictionary()
		param["stripeToken"] = token
		param["totalAmountWithoutShipping"] = total
		param["shippingAddressId"] = addShipping
		param["billingAddressId"] = reviewObj?.addressBilling?.id ?? addShipping
		if reviewObj?.cardList?.coupon?.name != nil {
			param["couponName"] = reviewObj?.cardList?.coupon?.name
		}
		
		param["totalAmountIncludeShipping"] = totalAmountIncludeShipping
		param["orderPerSellers"] = dict
        
//        print("subparams = \(subParam)")
		print("param = \(param)")
		return param as NSDictionary
    }
    private func getIdParams() -> ( disCount: Double, orderPerSellers:[NSDictionary] ){
        if let list =  self.reviewObj?.cardList?.cartItemsPerSeller {
            var listKeyPerSeller = [NSDictionary]()
            var disCount: Double = 0.0
            for item in list {
                var shipping = TAPShippingModel()
                for itemAdd in item.shippingOptions {
                    if itemAdd.isSelect == true {
                        shipping = itemAdd
                        if itemAdd.isPickup == true {
                            disCount += -(Double((itemAdd.additionalInfor?.cashbackPercentage)! / 100) * Double(item.totalPrice!))
                        }else {
                            disCount += Double(itemAdd.price!)
                        }
                    }
                }
                let dict: [String : Any] = ["sellerId" : item.sellerId ?? 0,
                                            "shippingId" : shipping.idShip ?? 0,
                                            "subAmount": item.totalPrice ?? 0]
                
                let nDict = dict as NSDictionary
                listKeyPerSeller.append(nDict)
            }
            return (disCount, listKeyPerSeller)
        }
        
        return (0.0, [])
    }
    private func jsonStringParam(param: [Dictionary<String, Any>]) -> String {
        do {
            
            //Convert to Data
            let jsonData = try JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Do this for print data only otherwise skip
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print(JSONString)
                return JSONString
            }else {
                return ""
            }
            
        } catch {
            return ""
        }
    }
    //    {
    //    "stripeToken" : "tok_1A7EhKGaV3oLL0KEZZoFzi2V",
    //    "totalAmountWithoutShipping" : 60,
    //    "totalAmountIncludeShipping": 62,
    //    "couponName" : "discount5",
    //    "shippingAddressId" : 1,
    //    "billingAddressId" : 1,
    //    "orderPerSellers": [{
    //    "sellerId" : 1,
    //    "shippingId": 1,
    //    "subAmount": 60
    //    }]
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TAPPayMentMethodView: TAPHeaderViewDelegate {
    func headerViewDidTouchBack() {
//        self.navigationController?.popViewController(animated: true)
    }
}

extension TAPPayMentMethodView: STPPaymentCardTextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField.isEqual(self.tfExpDate) {
//            let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
//            if (result.length() >= 11) {
//                return false
//            }
//            if (result.length() == 5 || result.length() == 8 || result.length() == 11) && string != ""{
//                textField.text?.append("/")
//            }
//        }
//
//        return true
//    }
}
