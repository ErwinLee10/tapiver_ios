//
//  TAPCategoryViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
//import SVProgressHUD
class TAPCategoryViewController: TAPBaseViewController {
    @IBOutlet weak var tableViewLever0: UITableView!
    @IBOutlet weak var tableViewLever1: UITableView!
//    @IBOutlet weak var viewHeader: TAPMainPageHeaderView!
    public var landMarkId: String?
    public var sellerId: String?
    var listobject: TAPListCategoryMenu = TAPListCategoryMenu()
    var indexLever0: IndexPath? = nil
    
    var errorInternetView: TAPLostConnectErrorView?
    var errorGeneralView: TAPGeneralErrorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIB()
        initData()
    }
    func initIB() {
        self.tableViewLever0 .register(UINib.init(nibName:"TAPCategoryLever0Cell", bundle: nil), forCellReuseIdentifier: "TAPCategoryLever0Cell")
        self.tableViewLever1 .register(UINib.init(nibName:"TAPCategoryLever1Cell", bundle: nil), forCellReuseIdentifier: "TAPCategoryLever1Cell")
        (self.headerView as? TAPMainPageHeaderView)?.delegate = self
    }
    func initData() {
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        header.setValue(TAPGlobal.shared.getLoginModel()?.webSessionId ?? "", forKey: "Authorization")
        let params:Dictionary = [TAPConstants.APIParams.landmarkId : landMarkId ?? "",
                                 TAPConstants.APIParams.hasProducts: "1",
                                 TAPConstants.APIParams.sellerId: sellerId ?? ""
        ]
        var apiPath: String
        
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = API_PATH(path: String.init(format: "/api/v1/categories", TAPGlobal.shared.getLoginModel()?.userId ?? ""))
        } else {
            apiPath = API_PATH(path: String.init(format: "/api/v1/s/overview", TAPGlobal.shared.getLoginModel()?.userId ?? ""))
        }
        //SVProgressHUD.show()
        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params as NSDictionary, headers: header, responseObjectClass: TAPListCategoryMenu()) { (success, response) in
            if success {
                guard let model = response as? TAPListCategoryMenu else {
                    return
                }
                self.listobject = model
                self.tableViewLever1.reloadData()
                self.tableViewLever0.reloadData()
            } else {
                TAPWebservice.shareInstance.checkHaveInternet(response: { (check) in
                    if check {
                        //server error
                        self.errorGeneralView = Bundle.main.loadNibNamed("TAPGeneralErrorView", owner: self, options: nil)![0] as? TAPGeneralErrorView
                        self.errorGeneralView?.frame = CGRect(x: self.tableViewLever0.frame.origin.x,
                                                              y: self.tableViewLever0.frame.origin.y,
                                                              width: self.tableViewLever0.frame.width + self.tableViewLever1.frame.width,
                                                              height: self.tableViewLever0.frame.height)
                        self.view.addSubview(self.errorGeneralView!)
                        self.view.bringSubview(toFront: self.errorGeneralView!)
                    }
                    else {
                        self.errorInternetView = Bundle.main.loadNibNamed("TAPLostConnectErrorView", owner: self, options: nil)![0] as? TAPLostConnectErrorView
                        self.errorInternetView?.frame = CGRect(x: self.tableViewLever0.frame.origin.x,
                                                               y: self.tableViewLever0.frame.origin.y,
                                                               width: self.tableViewLever0.frame.width + self.tableViewLever1.frame.width,
                                                               height: self.tableViewLever0.frame.height)
                        self.view.addSubview(self.errorInternetView!)
                        self.view.bringSubview(toFront: self.errorInternetView!)
                    }
                })
//                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
            }
            //SVProgressHUD.dismiss()
            TAPGlobal.shared.dismissLoading()
        }
        
    }
    
//    @IBAction func acTap(_ sender: Any) {
//        let string = """
//{
//  "cartItemsPerSeller": [
//    {
//      "sellerName": "Hung & Trang",
//      "sellerId": 1,
//      "sellerAddress": {
//        "id": 1,
//        "streetName": "29 Haji Lane",
//        "buildingName": "Haji Lane",
//        "floor": "",
//        "unitNumber": "",
//        "postalCode": "238898",
//        "contact": "+6567633612",
//        "shortDisplayAddress": "Haji Lane",
//        "landmark": {
//          "id": 1,
//          "name": "Haji Lane",
//          "picture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/tapiver/landmark/Haji+Lane.jpg"
//        },
//        "formattedAddress": "29 Haji Lane",
//        "formattedFloorAndUnitAddres": ""
//      },
//      "totalPrice": 65,
//      "productVariations": [
//        {
//          "name": "Sleeveless Tie-Waist Dress Green",
//          "brand": "Marc & Molly's",
//          "originalPrice": 65,
//          "salePrice": null,
//          "finalPrice": 65,
//          "quantity": 1,
//          "availableStock": 70,
//          "pictureUrl": "https://s3-ap-southeast-1.amazonaws.com/tapiver/hello@lucavic.com/PRODUCT/fcc23fc3-7c84-4a9a-809d-de148c1e007a.jpg",
//          "id": 45,
//          "size": "4",
//          "colorHexCode": "#3fb3b6",
//          "colorName": "",
//          "categoryId": 227,
//          "categoryName": "Girls",
//          "onSale": false
//        },
//{
//          "name": "Hungvt",
//          "brand": "Marc & Molly's",
//          "originalPrice": 65,
//          "salePrice": null,
//          "finalPrice": 65,
//          "quantity": 1,
//          "availableStock": 70,
//          "pictureUrl": "https://s3-ap-southeast-1.amazonaws.com/tapiver/hello@lucavic.com/PRODUCT/fcc23fc3-7c84-4a9a-809d-de148c1e007a.jpg",
//          "id": 45,
//          "size": "4",
//          "colorHexCode": "#3fb3b6",
//          "colorName": "",
//          "categoryId": 227,
//          "categoryName": "Girls",
//          "onSale": false
//        },
//{
//          "name": "Hungvt",
//          "brand": "Marc & Molly's",
//          "originalPrice": 65,
//          "salePrice": null,
//          "finalPrice": 65,
//          "quantity": 1,
//          "availableStock": 70,
//          "pictureUrl": "https://s3-ap-southeast-1.amazonaws.com/tapiver/hello@lucavic.com/PRODUCT/fcc23fc3-7c84-4a9a-809d-de148c1e007a.jpg",
//          "id": 45,
//          "size": "4",
//          "colorHexCode": "#3fb3b6",
//          "colorName": "",
//          "categoryId": 227,
//          "categoryName": "Girls",
//          "onSale": false
//        }
//      ],
//      "shippingOptions": [
//        {
//          "id": 1,
//          "provider": "",
//          "type": "Normal Shipping",
//          "price": 0,
//          "isPickup": false,
//          "additionalInformation": {
//            "time": "5 days",
//            "cashbackPercentage": null,
//            "cashbackEarned": null
//          },
//          "freeShipping": false
//        },
//        {
//          "id": 2,
//          "provider": "",
//          "type": "Registered Shipping",
//          "price": 3,
//          "isPickup": false,
//          "additionalInformation": {
//            "time": "2 days",
//            "cashbackPercentage": null,
//            "cashbackEarned": null
//          },
//          "freeShipping": false
//        },
//        {
//          "id": 4,
//          "provider": "Store",
//          "type": "Pickup",
//          "price": 0,
//          "isPickup": true,
//          "additionalInformation": {
//            "time": "1 day",
//            "cashbackPercentage": 5,
//            "cashbackEarned": 3.25
//          },
//          "freeShipping": false
//        }
//      ]
//    },
//    {
//      "sellerName": "Luca & Vic",
//      "sellerId": 1,
//      "sellerAddress": {
//        "id": 1,
//        "streetName": "29 Haji Lane",
//        "buildingName": "Haji Lane",
//        "floor": "",
//        "unitNumber": "",
//        "postalCode": "238898",
//        "contact": "+6567633612",
//        "shortDisplayAddress": "Haji Lane",
//        "landmark": {
//          "id": 1,
//          "name": "Haji Lane",
//          "picture": "https://s3-ap-southeast-1.amazonaws.com/tapiver/tapiver/landmark/Haji+Lane.jpg"
//        },
//        "formattedAddress": "29 Haji Lane",
//        "formattedFloorAndUnitAddres": ""
//      },
//      "totalPrice": 65,
//      "productVariations": [
//        {
//          "name": "Sleeveless Tie-Waist Dress Green",
//          "brand": "Marc & Molly's",
//          "originalPrice": 65,
//          "salePrice": null,
//          "finalPrice": 65,
//          "quantity": 1,
//          "availableStock": 70,
//          "pictureUrl": "https://s3-ap-southeast-1.amazonaws.com/tapiver/hello@lucavic.com/PRODUCT/fcc23fc3-7c84-4a9a-809d-de148c1e007a.jpg",
//          "id": 45,
//          "size": "4",
//          "colorHexCode": "#3fb3b6",
//          "colorName": "",
//          "categoryId": 227,
//          "categoryName": "Girls",
//          "onSale": false
//        }
//      ],
//      "shippingOptions": [
//        {
//          "id": 1,
//          "provider": "",
//          "type": "Normal Shipping",
//          "price": 0,
//          "isPickup": false,
//          "additionalInformation": {
//            "time": "5 days",
//            "cashbackPercentage": null,
//            "cashbackEarned": null
//          },
//          "freeShipping": false
//        },
//        {
//          "id": 2,
//          "provider": "",
//          "type": "Registered Shipping",
//          "price": 3,
//          "isPickup": false,
//          "additionalInformation": {
//            "time": "2 days",
//            "cashbackPercentage": null,
//            "cashbackEarned": null
//          },
//          "freeShipping": true
//        },
//        {
//          "id": 4,
//          "provider": "Store",
//          "type": "Pickup",
//          "price": 0,
//          "isPickup": true,
//          "additionalInformation": {
//            "time": "1 day",
//            "cashbackPercentage": 10,
//            "cashbackEarned": 3.25
//          },
//          "freeShipping": false
//        }
//      ]
//    }
//  ],
//  "coupon": null,
//  "finalTotalAmount": 65,
//  "originalTotalAmount": 65
//}
//"""
//        let dict = convertToDictionary(text: string)
//        let tap: TAPAddressMethodController = TAPAddressMethodController()
//        tap.cardList = TAPCartListModel()
//        tap.cardList?.parserResponse(dic: dict! as NSDictionary)
//        tap.hidesBottomBarWhenPushed = true;
//        self.navigationController?.pushViewController(tap, animated: true)
//    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension TAPCategoryViewController: UITableViewDelegate {
    
}

extension TAPCategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableViewLever0 {
            return self.listobject.listCategory!.count
        }else{
            if indexLever0 == nil{
                return 0
            }else{
                let index = self.indexLever0!.row
                let item:TAPCategoryMenuEntity = self.listobject.listCategory![index]
                return item.listSub!.count
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableViewLever0 {
            return 80
        }else{
            if self.indexLever0 == nil {
                return 0
            }else {
                let index = self.indexLever0!.row
                guard let items:TAPCategoryMenuEntity = self.listobject.listCategory?[index] else{
                    return 0
                }
                guard let item:TAPCategoryMenuEntity = items.listSub?[indexPath.row] else{
                    return 0
                }
                if item.isSelected == true {
                    return (CGFloat)(item.listSub!.count + 1) * 44.0
                }else {
                    return 44
                }
                
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableViewLever0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPCategoryLever0Cell", for: indexPath) as? TAPCategoryLever0Cell else {
                return UITableViewCell()
            }
            let item:TAPCategoryMenuEntity = self.listobject.listCategory![indexPath.row]
            cell.setDataMenu0(object: item)
            return cell
        }else{
            if self.indexLever0 == nil{
                return UITableViewCell()
            }else{
                let index = self.indexLever0!.row
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPCategoryLever1Cell", for: indexPath) as? TAPCategoryLever1Cell else {
                    return UITableViewCell()
                }
                guard let items:TAPCategoryMenuEntity = self.listobject.listCategory?[index] else{
                    return UITableViewCell()
                    
                }
                guard let item :TAPCategoryMenuEntity = items.listSub?[indexPath.row] else {
                    return UITableViewCell()
                    
                }
                cell.delegate = self
                cell.indexLever1 = indexPath
                cell.lbNameSubMenu.text = item.name
                if item.isSelected == false {
                    cell.reloadData(lists: [])
                }else {
                    cell.reloadData(lists: item.listSub!)
                }
                return cell
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableViewLever0 {
            self.indexLever0 = indexPath 
            let index = self.indexLever0!.row
            resetSelectAt(index: index, ofList: self.listobject.listCategory!)
        }else {
            let index = self.indexLever0!.row
            let items:TAPCategoryMenuEntity = self.listobject.listCategory![index]
            resetSelectAt(index: indexPath.row, ofList: items.listSub!)
        }
        self.tableViewLever0.reloadData()
        self.tableViewLever1.reloadData()
       
    }
    func resetSelectAt (index: Int, ofList:[TAPCategoryMenuEntity]) {
        
        for item in ofList {
            if (ofList.index(of: item) == index){
                item.isSelected = true
            }else{
                item.isSelected = false
            }
        }
    }
}

extension TAPCategoryViewController: TAPCategoryLever1CellDelegate {
    
    func tapMenu1At(index1: IndexPath, subIndex1: IndexPath) {
        print("Tap  index = \(self.indexLever0!.row) at index menu 1 = \(index1.row) subindex = \(subIndex1.row)")
    }
    
    func objectWhenTap(object: TAPCategoryMenuEntity) {
        print("OBJ >>>> \(object)")
        // lấy object.idMenu
    }
    
}

extension TAPCategoryViewController: TAPMainPageHeaderViewDelegate {
    func headerViewDidTouchLeftMenu() {
        
    }
    
    func headerViewDidTouchMenu() {
        showRightMenu()
    }
    
    func headerViewDidTouchCart() {
        
    }
    
    func headerViewDidTouchSearch() {
        
    }
}
