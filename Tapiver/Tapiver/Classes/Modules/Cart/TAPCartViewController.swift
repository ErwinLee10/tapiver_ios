//
//  TAPCartViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
//import SVProgressHUD

class TAPCartViewController: TAPBaseViewController {
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var proceedToCheckoutBtn: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var couponButton: UIButton!
    @IBOutlet weak var couponView: UIView!
    @IBOutlet weak var couponTextField: UITextField!
    @IBOutlet weak var emptyLabel: UILabel!
    
    var cartListModel: TAPCartListModel?
    var voucherName: String?
    let cellIdentifier = "TAPCartTableViewCell"
    let couponCellIdentifier = "TAPCartCouponTableViewCell"
    
    var errorInternetView: TAPLostConnectErrorView?
    var errorGeneralView: TAPGeneralErrorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        cartListModel = TAPCartListModel()
//        cartListModel?.cartItemsPerSeller = [TAPCartItemModel(), TAPCartItemModel(), TAPCartItemModel()]
        getData(hasVoucher: false)
    }

    @IBAction func proceedToCheckoutTouched(_ sender: Any) {
        let checkout = TAPAddressMethodController.init(nibName: "TAPAddressMethodController", bundle: nil)
        checkout.cardList = cartListModel
        self.navigationController?.pushViewController(checkout, animated: true)
    }
    
    // MARK: Action
    @IBAction func couponButtonTouched(_ sender: Any) {
        showCouponView(true)
    }
    
    @IBAction func couponSubmitTouched(_ sender: Any) {
        showCouponView(false)
        getData(hasVoucher: true)
    }
    
    // MARK: Private
    private func setupView() {
        proceedToCheckoutBtn.setBackgroundImage(UIImage.imageFromColor(UIColor(netHex: 0x1CAAB6)), for: .normal)
        contentTableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        contentTableView.register(UINib.init(nibName: couponCellIdentifier, bundle: nil), forCellReuseIdentifier: couponCellIdentifier)
        contentTableView.separatorStyle = .none
        contentTableView.allowsSelection = false
        contentTableView.tableFooterView = UIView(frame: CGRect.init(x: 0, y: 0, width: contentTableView.frame.width, height: 0.01))
        
        // Hide header button
        if let header = (headerView as? TAPHeaderView) {
            header.hideSearchButton(true)
            header.hideCartButton(true)
            header.hideMenuButton(true)
        }
        
        // Defaul value
        totalPriceLabel.text = ""
        let attText = NSMutableAttributedString(string: "Have a coupon?")
        attText.addAttributes([NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue], range: NSRange.init(location: 0, length: attText.length))
        couponButton.setAttributedTitle(attText, for: .normal)
        
        showCouponView(false)
    }
    
    private func reloadData() {
        
        if let carItems = cartListModel?.cartItemsPerSeller, carItems.count > 0 {
            contentTableView.isHidden = false
            emptyLabel.isHidden = true
            footerView.isHidden = false
            
            contentTableView.reloadData()
            let total = NSNumber(value: cartListModel?.finalTotalAmount ?? 0).moneyString()
            totalPriceLabel.text = "Total: \(total)"
            
        } else {
            contentTableView.isHidden = true
            emptyLabel.isHidden = false
            footerView.isHidden = true
        }
    }
    
    private func showCouponView(_ show: Bool) {
        couponView.isHidden = !show
    }
    
    private func updateCoupon() {
        var discountStr = "Discount:"
        let saveMoney = NSNumber(value: cartListModel?.coupon?.totalSaving ?? 0).moneyString()
        if let isPercent = cartListModel?.coupon?.isPercentageDiscount, isPercent == true {
            let percent = cartListModel?.coupon?.percentage ?? 0
            discountStr += "\(percent)% (-\(saveMoney))"
        } else {
            discountStr += "-\(saveMoney)"
        }
        couponButton.setTitleColor(UIColor.init(netHex: 0xEC2327), for: .normal)
        couponButton.setTitle(discountStr, for: .normal)
        couponButton.setAttributedTitle(nil, for: .normal)
        couponButton.isUserInteractionEnabled = false
    }
    
    private func showInvalidCouponAlert() {
        TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Invalid coupon", positive: "OK", positiveHandler: nil, vc: self)
    }
}

// MARK: Call API
extension TAPCartViewController {
    private func getData(hasVoucher: Bool) {
        // Dummy data
//        let filePath = Bundle.main.path(forResource: "CarDummy", ofType: "geojson")
//        if let data = NSData(contentsOfFile: filePath ?? "") as Data? {
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
//                if let jsonObj = json as? NSDictionary {
//                    self.cartListModel = TAPCartListModel()
//                    cartListModel?.parserResponse(dic: jsonObj)
//                    self.reloadData()
//
//                    if hasVoucher {
//                        self.updateCoupon()
//                    }
//                }
//            } catch {
//
//            }
//        }
//        return
        
        if(TAPGlobal.shared.hasLogin()) {
            let params: [String: Any] = [:]
            var apiPath = ""
            if hasVoucher && voucherName != nil {
                apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/cart/voucher/\(voucherName!)"
            } else {
                apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/cart"
            }
            
            //SVProgressHUD.show()
            TAPGlobal.shared.showLoading()
            TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params, responseObjectClass: TAPCartListModel()) { [weak self] (success, responseEntity) in
                if success, let cartListModel = responseEntity as? TAPCartListModel {
                    self?.cartListModel = cartListModel
                    self?.reloadData()
                    
                    if hasVoucher {
                        self?.updateCoupon()
                    }
                } else {
                    if hasVoucher {
                        self?.showInvalidCouponAlert()
                    }
                    else {
                        TAPWebservice.shareInstance.checkHaveInternet(response: { (check) in
                            if check {
                                //server error
                                guard let unwrappedSelf = self else { return }
                                unwrappedSelf.errorGeneralView = Bundle.main.loadNibNamed("TAPGeneralErrorView", owner: unwrappedSelf, options: nil)![0] as? TAPGeneralErrorView
                                //unwrappedSelf.errorGeneralView?.frame = unwrappedSelf.contentTableView.frame
                                unwrappedSelf.errorGeneralView?.frame = CGRect(x: unwrappedSelf.contentTableView.frame.origin.x,
                                                                               y: unwrappedSelf.contentTableView.frame.origin.y,
                                                                               width: unwrappedSelf.contentTableView.frame.width,
                                                                               height: unwrappedSelf.view.frame.height - (unwrappedSelf.headerView?.frame.height)!)
                                unwrappedSelf.view.addSubview(unwrappedSelf.errorGeneralView!)
                                unwrappedSelf.view.bringSubview(toFront: unwrappedSelf.errorGeneralView!)
                            }
                            else {
                                guard let unwrappedSelf = self else { return }
                                unwrappedSelf.errorInternetView = Bundle.main.loadNibNamed("TAPLostConnectErrorView", owner: unwrappedSelf, options: nil)![0] as? TAPLostConnectErrorView
                                //unwrappedSelf.errorInternetView?.frame = unwrappedSelf.contentTableView.frame
                                unwrappedSelf.errorInternetView?.frame = CGRect(x: unwrappedSelf.contentTableView.frame.origin.x,
                                                                                y: unwrappedSelf.contentTableView.frame.origin.y,
                                                                                width: unwrappedSelf.contentTableView.frame.width,
                                                                                height: unwrappedSelf.view.frame.height - (unwrappedSelf.headerView?.frame.height)!)
                                unwrappedSelf.view.addSubview(unwrappedSelf.errorInternetView!)
                                unwrappedSelf.view.bringSubview(toFront: unwrappedSelf.errorInternetView!)
                            }
                        })
                    }
                }
                //SVProgressHUD.dismiss()
                TAPGlobal.shared.dismissLoading()
            }
        } else {
            
        }
    }
    
    private func deleteItem(productVariationId: Int) {
        let apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/cart/productVariationId/\(productVariationId)"
        
        //SVProgressHUD.show()
        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendDELETERequest(path: apiPath) { [weak self] (success) in
            //SVProgressHUD.dismiss()
            TAPGlobal.shared.dismissLoading()
            guard let strongSelf = self else { return }
            if success {
                strongSelf.getData(hasVoucher: strongSelf.voucherName != nil && strongSelf.voucherName!.isEmpty == false)
            }
        }
    }
}

extension TAPCartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let carItems = cartListModel?.cartItemsPerSeller, carItems.count > 0 else {
            return 0
        }
        return carItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let carItems = cartListModel?.cartItemsPerSeller, carItems.count > 0 else {
            return 0
        }
//        if section == numberOfSections(in: tableView) - 1 {
//            return 1
//        } else {
//            let products = carItems[section].productVariations
//            return products.count
//        }
        let products = carItems[section].productVariations
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section != numberOfSections(in: tableView) - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TAPCartTableViewCell
            cell.delegate = self
            if let carItems = cartListModel?.cartItemsPerSeller {
                let products = carItems[indexPath.section].productVariations
                cell.fillData(data: products[indexPath.row])
            }
            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: couponCellIdentifier, for: indexPath) as! TAPCartCouponTableViewCell
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == numberOfSections(in: tableView) - 1 {
//            return nil
//        }
        let nibs = Bundle.main.loadNibNamed("TAPCartHeaderTableViewCell", owner: self, options: nil)
        let header = nibs?.first as? TAPCartHeaderTableViewCell
        if let carItems = cartListModel?.cartItemsPerSeller {
            let headerText = carItems[section].sellerName
            header?.setTitle(headerText)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if section == numberOfSections(in: tableView) - 1 {
//            return nil
//        }
        let nibs = Bundle.main.loadNibNamed("TAPCartFooterTableViewCell", owner: self, options: nil)
        let footer = nibs?.first as? TAPCartFooterTableViewCell
        if let carItems = cartListModel?.cartItemsPerSeller {
            let price = carItems[section].totalPrice
            footer?.setTotalPrice(price ?? 0)
        }
        return footer
    }
}

extension TAPCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section != numberOfSections(in: tableView) - 1 {
//            return 80
//        } else {
//            return 120
//        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section != numberOfSections(in: tableView) - 1 {
            return 54
//        } else {
//            return 0
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section != numberOfSections(in: tableView) - 1 {
            return 44
//        } else {
//            return 0
//        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.section == numberOfSections(in: tableView) - 1 {
//            return
//        }
        cell.backgroundColor = UIColor.clear
        let layer: CAShapeLayer  = CAShapeLayer()
        let pathRef: CGMutablePath  = CGMutablePath()
        let bounds: CGRect  = cell.bounds.insetBy(dx: 10, dy: 0)
        
        pathRef.addRect(bounds)
        layer.path = pathRef
        //set the border color
        //            layer.strokeColor = UIColor.lightGray.cgColor;
        //set the border width
        layer.lineWidth = 1
        layer.fillColor = UIColor(white: 1, alpha: 1.0).cgColor
        
        let bgView: UIView = UIView(frame:bounds)
        bgView.layer.insertSublayer(layer, at: 0)
        bgView.backgroundColor = UIColor.clear
        cell.backgroundView = bgView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if section == numberOfSections(in: tableView) - 1 {
//            return
//        }
        let cornerRadius: CGFloat = 10
        view.backgroundColor = UIColor.clear
        let layer: CAShapeLayer  = CAShapeLayer()
        let pathRef: CGMutablePath  = CGMutablePath()
        let bounds: CGRect  = CGRect.init(x: 10, y: 10, width: view.frame.width - 20, height: view.frame.height - 10)
        
        pathRef.move(to: CGPoint(x:bounds.minX,y:bounds.maxY))
        pathRef.addArc(tangent1End: CGPoint(x:bounds.minX,y:bounds.minY), tangent2End: CGPoint(x:bounds.midX,y:bounds.minY), radius: cornerRadius)
        
        pathRef.addArc(tangent1End: CGPoint(x:bounds.maxX,y:bounds.minY), tangent2End: CGPoint(x:bounds.maxX,y:bounds.midY), radius: cornerRadius)
        pathRef.addLine(to: CGPoint(x:bounds.maxX,y:bounds.maxY))
        
        layer.path = pathRef
        //set the border color
//        layer.strokeColor = UIColor.lightGray.cgColor;
        //set the border width
        layer.lineWidth = 1
        layer.fillColor = UIColor(white: 1, alpha: 1.0).cgColor
        
        view.layer.insertSublayer(layer, at: 0)
            
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        if section == numberOfSections(in: tableView) - 1 {
//            return
//        }
        
        let cornerRadius: CGFloat = 10
        view.backgroundColor = UIColor.clear
        let layer: CAShapeLayer  = CAShapeLayer()
        let pathRef: CGMutablePath  = CGMutablePath()
        let bounds: CGRect  = CGRect.init(x: 10, y: 0, width: view.frame.width - 20, height: view.frame.height - 10)
        
        pathRef.move(to: CGPoint(x:bounds.minX,y:bounds.minY))
        pathRef.addArc(tangent1End: CGPoint(x:bounds.minX,y:bounds.maxY), tangent2End: CGPoint(x:bounds.midX,y:bounds.maxY), radius: cornerRadius)

        pathRef.addArc(tangent1End: CGPoint(x:bounds.maxX,y:bounds.maxY), tangent2End: CGPoint(x:bounds.maxX,y:bounds.midY), radius: cornerRadius)
        pathRef.addLine(to: CGPoint(x:bounds.maxX,y:bounds.minY))
        
        layer.path = pathRef
        //set the border color
//        layer.strokeColor = UIColor.lightGray.cgColor;
        //set the border width
        layer.lineWidth = 1
        layer.fillColor = UIColor(white: 1, alpha: 1.0).cgColor
        
        view.layer.insertSublayer(layer, at: 0)
    }
}

extension TAPCartViewController: TAPCartTableViewCellDelegate {
    func cartCellDeleteItem(productVariationId: Int) {
        deleteItem(productVariationId: productVariationId)
    }
}
