//
//  TAPAddressMethodController.swift
//  Tapiver
//
//  Created by Hung vu on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD

class TAPAddressMethodController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var isLoadedApi: Bool = false
    private var isSelectSameAs: Bool = true
    var listData = NSMutableArray()
    var listShipping = [TAPChecOutEntity]()
    var listBilling = [TAPChecOutEntity]()
    public var cardList: TAPCartListModel?
    
    @IBOutlet weak var headerView: TAPHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIb()
        initData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isLoadedApi {
            initData()
        }
    }
    func initData() {
        self.listShipping = [TAPChecOutEntity]()
        self.listBilling = [TAPChecOutEntity]()
        callApi()
    }
    func createListData(listShipping:[TAPChecOutEntity], listBilling:[TAPChecOutEntity]) {
        self.listData.removeAllObjects()
        var listDataSection0 = [TAPChecOutEntity]()
        let header: TAPChecOutEntity = TAPChecOutEntity()
        header.typeCheckOutCell = CheckOutEntytiType.headerShippingAddress
        listDataSection0.append(header)
        for item0 in listShipping {
            let ite = TAPChecOutEntity()
            ite.typeCheckOutCell  = CheckOutEntytiType.addressShipping
            ite.addObj = item0.addObj
            ite.isSelected = item0.isSelected
            listDataSection0.append(ite)
        }
        let bottomButtonShipping:TAPChecOutEntity = TAPChecOutEntity()
        bottomButtonShipping.typeCheckOutCell = CheckOutEntytiType.addNewAdressShipping
        listDataSection0.append(bottomButtonShipping)
        
        let headerBill: TAPChecOutEntity = TAPChecOutEntity()
        header.typeCheckOutCell = CheckOutEntytiType.headerBillingAddress
        listDataSection0.append(headerBill)
        for item1 in listBilling {
            let ite1 = TAPChecOutEntity()
            ite1.typeCheckOutCell  = CheckOutEntytiType.addressBilling
            ite1.addObj = item1.addObj
            ite1.isSelected = item1.isSelected
            listDataSection0.append(ite1)
        }
        let bottomButtonBilling:TAPChecOutEntity = TAPChecOutEntity()
        bottomButtonBilling.typeCheckOutCell = CheckOutEntytiType.addNewAdressBilling
        listDataSection0.append(bottomButtonBilling)
        self.listData.add(listDataSection0)
        
        let listDataSection1:NSMutableArray = NSMutableArray()
        let cellShippingMethod: TAPChecOutEntity = TAPChecOutEntity()
        cellShippingMethod.typeCheckOutCell = CheckOutEntytiType.shippingMethod
        listDataSection1.add(cellShippingMethod)
        self.listData.add(listDataSection1)
        
        self.tableView.reloadData()
    }
    func initIb() {
        self.headerView.delegate = self
        self.tableView.register(UINib.init(nibName: "TAPHeaderAddTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPHeaderAddTableViewCell")
        self.tableView.register(UINib.init(nibName: "TAPAddessCell", bundle: nil), forCellReuseIdentifier: "TAPAddessCell")
        self.tableView.register(UINib.init(nibName: "TAPShippingMethodCell", bundle: nil), forCellReuseIdentifier: "TAPShippingMethodCell")
        self.tableView.register(UINib.init(nibName: "TAPAddNewAddressCell", bundle: nil), forCellReuseIdentifier: "TAPAddNewAddressCell")
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    // MARK: call api
    func callApi() {
        var apiPath: String
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = API_PATH(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/address")
        }else {
            apiPath = TAPConstants.APIPath.overview
        }
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        header.setValue(TAPGlobal.shared.getLoginModel()?.webSessionId ?? "", forKey: "Authorization")
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: nil, headers: header, responseObjectClass: TAPListChecOutEntity()) { (success, response) in
            if success {
                self.isLoadedApi = true
                guard let model = response as? TAPListChecOutEntity else {
                    return
                }
                self.listShipping =  model.listCheckOut
                for item in self.listShipping {
                    if item.isSelected == false {
                        self.listBilling.append(item)
                    }
                }
                if self.isSelectSameAs == false {
                    self.createListData(listShipping: self.listShipping, listBilling: self.listBilling)
                }else {
                    self.createListData(listShipping: self.listShipping, listBilling: [])
                }
                
            } else {
                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
            }
            SVProgressHUD.dismiss()
        }
        
    }
  
    @IBAction func acPushOrder(_ sender: Any) {
        let review = TAPReViewOrderController.init(nibName: "TAPReViewOrderController", bundle: nil)
        self.navigationController?.pushViewController(review, animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension TAPAddressMethodController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (cell.responds(to: #selector(getter: UIView.tintColor))) {
            let cornerRadius: CGFloat = 5
            cell.backgroundColor = UIColor.clear
            let layer: CAShapeLayer  = CAShapeLayer()
            let pathRef: CGMutablePath  = CGMutablePath()
            let bounds: CGRect  = cell.bounds.insetBy(dx: 0, dy: 0)
            var addLine: Bool  = false
            if (indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1) {
                pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
            } else if (indexPath.row == 0) {
                pathRef.move(to: CGPoint(x:bounds.minX,y:bounds.maxY))
                pathRef.addArc(tangent1End: CGPoint(x:bounds.minX,y:bounds.minY), tangent2End: CGPoint(x:bounds.midX,y:bounds.minY), radius: cornerRadius)
                
                pathRef.addArc(tangent1End: CGPoint(x:bounds.maxX,y:bounds.minY), tangent2End: CGPoint(x:bounds.maxX,y:bounds.midY), radius: cornerRadius)
                pathRef.addLine(to: CGPoint(x:bounds.maxX,y:bounds.maxY))
                addLine = true;
            } else if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1) {
                
                pathRef.move(to: CGPoint(x:bounds.minX,y:bounds.minY))
                pathRef.addArc(tangent1End: CGPoint(x:bounds.minX,y:bounds.maxY), tangent2End: CGPoint(x:bounds.midX,y:bounds.maxY), radius: cornerRadius)
                
                pathRef.addArc(tangent1End: CGPoint(x:bounds.maxX,y:bounds.maxY), tangent2End: CGPoint(x:bounds.maxX,y:bounds.midY), radius: cornerRadius)
                pathRef.addLine(to: CGPoint(x:bounds.maxX,y:bounds.minY))
                
            } else {
                pathRef.addRect(bounds)
                addLine = true
            }
            layer.path = pathRef
            //CFRelease(pathRef)
            //set the border color
            layer.strokeColor = UIColor.clear.cgColor;
            //set the border width
            layer.lineWidth = 1
            layer.fillColor = UIColor.white.cgColor
            
            
            if (addLine == true) {
                let lineLayer: CALayer = CALayer()
                let lineHeight: CGFloat  = (1 / UIScreen.main.scale)
                lineLayer.frame = CGRect(x:bounds.minX, y:bounds.size.height-lineHeight, width:bounds.size.width, height:lineHeight)
                lineLayer.backgroundColor = tableView.separatorColor!.cgColor
                layer.addSublayer(lineLayer)
            }
            
            let testView: UIView = UIView(frame:bounds)
            testView.layer.insertSublayer(layer, at: 0)
            testView.backgroundColor = UIColor.clear
            cell.backgroundView = testView
        }
        
    }
}
extension TAPAddressMethodController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection0:[TAPChecOutEntity] = self.listData[section] as? [TAPChecOutEntity] else {
            return 0
        }
        return listSection0.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var viewF = UIView()
        if section == 0 {
            viewF = UIView.init(frame: CGRect(x:0, y:0, width:self.tableView.frame.size.width, height:5))
        }else {
            viewF = UIView.init(frame: CGRect(x:0, y:0, width:self.tableView.frame.size.width, height:2))
        }
        viewF.backgroundColor = UIColor.clear
        return viewF
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }else {
            return 366
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reCell = UITableViewCell()
        guard let listSection:[TAPChecOutEntity] = self.listData[indexPath.section] as? [TAPChecOutEntity] else {
            return reCell
        }
        let checkOut: TAPChecOutEntity! = listSection[indexPath.row]
        switch checkOut.typeCheckOutCell {
        case .headerBillingAddress, .headerShippingAddress:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPHeaderAddTableViewCell", for: indexPath) as? TAPHeaderAddTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            if checkOut.typeCheckOutCell == .headerShippingAddress {
                cell.isHeaderCheckBox = false
            } else {
                cell.isHeaderCheckBox = true
            }
            cell.setData()
            cell.btCheckBox.isSelected = isSelectSameAs
            reCell = cell
            break
        case .addressShipping, .addressBilling :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPAddessCell", for: indexPath) as? TAPAddessCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.index = indexPath
            cell.obj = checkOut
            cell.setData()
            reCell = cell
            break
        case .addNewAdressShipping, .addNewAdressBilling:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPAddNewAddressCell", for: indexPath) as? TAPAddNewAddressCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.index = indexPath
            if checkOut.typeCheckOutCell == .addNewAdressShipping {
                cell.isAdressShipping = true
            }else {
                cell.isAdressShipping = false
            }
            reCell = cell
            break
        case .shippingMethod:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPShippingMethodCell", for: indexPath) as? TAPShippingMethodCell else {
                return UITableViewCell()
            }
            cell.setData()
            reCell = cell
            break
        default:
            return reCell
        }
        
        return reCell
    }
}

extension TAPAddressMethodController: TAPHeaderViewDelegate {
    func headerViewDidTouchBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TAPAddressMethodController: TAPShippingMethodCellDelegate {
    func acSelectShippingMethodAt(index: IndexPath, obj: TAPSubShippingEntity) {
        
    }
}
extension TAPAddressMethodController: TAPAddessCellDelegate {
    func acSelectAddAt(index: IndexPath, withObj:TAPChecOutEntity) {
        self.listBilling = [TAPChecOutEntity]()
        for item in self.listShipping {
            let inx = self.listShipping.index(of: item)
            if (inx == index.row - 1) {
                item.isSelected = true
            }else {
                item.isSelected = false
                self.listBilling.append(item);
            }
        }
        if isSelectSameAs == false {
            self.createListData(listShipping: self.listShipping, listBilling: self.listBilling)
        }else {
            self.createListData(listShipping: self.listShipping, listBilling: [])
        }
    }
}

extension TAPAddressMethodController: TAPHeaderAddCellDelegate {
    func tapSelectSameasShipping(isSelect: Bool) {
        print("tapSelectSameasShipping = \(isSelect)")
        isSelectSameAs = isSelect
        if isSelect == false {
            self.createListData(listShipping: self.listShipping, listBilling: self.listBilling)
        }else {
            self.createListData(listShipping: self.listShipping, listBilling: [])
        }
        self.tableView.reloadData()
    }
}
extension TAPAddressMethodController: TAPAddNewAddressCellDelegate {
    
    func tapAddNewAddAt(index: IndexPath, isAddShipping: Bool) {
        print("add new")
        let addNew = TAPAddNewAddressViewController.init(nibName: "TAPAddNewAddressViewController", bundle: nil)
        
        self.navigationController?.pushViewController(addNew, animated: true)
    }
}
