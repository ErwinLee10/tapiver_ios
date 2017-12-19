//
//  TAPAddressMethodController.swift
//  Tapiver
//
//  Created by Hung vu on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPAddressMethodController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var isLoadedApi: Bool! = false
    var listData = NSMutableArray()
    @IBOutlet weak var headerView: TAPHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIb()
        initData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLoadedApi {
            callApi()
        }
    }
    func initData() {
        let bottomButtonShipping:TAPChecOutEntity = TAPChecOutEntity()
        bottomButtonShipping.typeCheckOutCell = CheckOutEntytiType.addNewAdressShipping
        
        let bottomButtonBilling:TAPChecOutEntity = TAPChecOutEntity()
        bottomButtonBilling.typeCheckOutCell = CheckOutEntytiType.addNewAdressBilling
        
        let listDataSection0:NSMutableArray = NSMutableArray()
        let header: TAPChecOutEntity = TAPChecOutEntity()
        header.typeCheckOutCell = CheckOutEntytiType.headerShippingAddress
        let headerBill: TAPChecOutEntity = TAPChecOutEntity()
        header.typeCheckOutCell = CheckOutEntytiType.headerBillingAddress
        listDataSection0.add(header)
        for var i in 0...2 {
            let checkout = TAPChecOutEntity()
            checkout.typeCheckOutCell =  CheckOutEntytiType.address
            checkout.addObj = TAPAddressModel()
            checkout.addObj?.contact = "Jasper Teo-\(i)"
            checkout.addObj?.streetName = """
            Blk 220 Lorong 3 Anson Road-\(i)
            #01-03 - \(i)
            s456723 - \(i)
            84182240 - \(i)
            """
            listDataSection0.add(checkout)
        }
        listDataSection0.add(bottomButtonShipping)
        listDataSection0.add(headerBill)
        for var i in 0...1 {
            let checkout = TAPChecOutEntity()
            checkout.typeCheckOutCell =  CheckOutEntytiType.address
            checkout.addObj = TAPAddressModel()
            checkout.addObj?.contact = "Jasper Teo-\(i)"
            checkout.addObj?.streetName = """
            Blk 220 Lorong 3 Anson Road-\(i)
            #01-03 - \(i)
            s456723 - \(i)
            84182240 - \(i)
            """
            listDataSection0.add(checkout)
        }
        listDataSection0.add(bottomButtonBilling)
        
        self.listData.add(listDataSection0)
        
        let listDataSection1:NSMutableArray = NSMutableArray()
        let cellShippingMethod: TAPChecOutEntity = TAPChecOutEntity()
        cellShippingMethod.typeCheckOutCell = CheckOutEntytiType.shippingMethod
        listDataSection1.add(cellShippingMethod)
        
        self.listData.add(listDataSection1)
    }
    func initIb() {
        self.headerView.delegate = self
        self.tableView.register(UINib.init(nibName: "TAPHeaderAddTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPHeaderAddTableViewCell")
        self.tableView.register(UINib.init(nibName: "TAPAddessCell", bundle: nil), forCellReuseIdentifier: "TAPAddessCell")
        self.tableView.register(UINib.init(nibName: "TAPShippingMethodCell", bundle: nil), forCellReuseIdentifier: "TAPShippingMethodCell")
        self.tableView.register(UINib.init(nibName: "TAPAddNewAddressCell", bundle: nil), forCellReuseIdentifier: "TAPAddNewAddressCell")
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableHeaderView?.backgroundColor  = UIColor.clear
        self.tableView.tableFooterView?.backgroundColor  = UIColor.clear
    }
    // MARK: call api
    func callApi() {
        
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
        return 2
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
            reCell = cell
            break
        case .address:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPAddessCell", for: indexPath) as? TAPAddessCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.index = indexPath
            cell.obj = (listSection[indexPath.row]).addObj
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
    func acSelectAddAt(index: IndexPath, withObj:TAPAddressModel) {
        
    }
}

extension TAPAddressMethodController: TAPHeaderAddCellDelegate {
    func tapSelectSameasShipping(isSelect: Bool) {
        print("tapSelectSameasShipping")
    }
}
extension TAPAddressMethodController: TAPAddNewAddressCellDelegate {
    
    func tapAddNewAddAt(index: IndexPath, isAddShipping: Bool) {
        print("add new")
    }
}
