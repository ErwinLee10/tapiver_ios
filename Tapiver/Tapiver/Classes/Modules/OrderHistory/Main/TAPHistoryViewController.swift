//
//  TAPHistoryViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
//import SVProgressHUD

class TAPHistoryViewController: TAPBaseViewController {
    @IBOutlet weak var contentTableView: UITableView!
    var orderList: [TAPOrderModel] = []
    
    var errorInternetView: TAPLostConnectErrorView?
    var errorGeneralView: TAPGeneralErrorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
//        orderList = [TAPOrderModel(), TAPOrderModel(), TAPOrderModel()]
        getData()
        
    }
    
    private func setupView() {
        contentTableView.register(UINib.init(nibName: "TAPHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPHistoryTableViewCell")
        contentTableView.register(UINib.init(nibName: "TAPHistoryOrderInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPHistoryOrderInformationTableViewCell")
        contentTableView.register(UINib.init(nibName: "TAPHistoryHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "TAPHistoryHeaderView")
        
        // Hide header button
        if let header = (headerView as? TAPHeaderView) {
            header.setHeaderTitle("Order History")
            header.hideSearchButton(true)
            header.hideCartButton(true)
            header.hideMenuButton(true)
        }
    }
    
    private func getData() {
//        // Dummy data - start
//        let filePath = Bundle.main.path(forResource: "HistoryDummy", ofType: "geojson")
//        if let data = NSData(contentsOfFile: filePath ?? "") as Data? {
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
//                if let jsonObj = json as? [NSDictionary] {
//                    let historyModel = TAPHistoryModel()
//                    historyModel.parserResponseArray(dics: jsonObj)
//                    self.orderList = historyModel.orderList
//                    self.reloadData()
//                }
//            } catch {
//                
//            }
//        }
//        return
//        // Dummy data - end
        
        if(TAPGlobal.shared.hasLogin()) {
            let params: [String: Any] = [:]
            let apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/orders"
            
            //SVProgressHUD.show()
            TAPGlobal.shared.showLoading()
            TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params, responseObjectClass: TAPHistoryModel()) { [weak self] (success, responseEntity) in
                if success, let historyModel = responseEntity as? TAPHistoryModel {
                    self?.orderList = historyModel.orderList
                    self?.reloadData()
                }
                else {
                    TAPWebservice.shareInstance.checkHaveInternet(response: { (check) in
                        if check {
                            //server error
                            guard let unwrappedSelf = self else { return }
                            unwrappedSelf.errorGeneralView = Bundle.main.loadNibNamed("TAPGeneralErrorView", owner: unwrappedSelf, options: nil)![0] as? TAPGeneralErrorView
                            unwrappedSelf.errorGeneralView?.frame = unwrappedSelf.contentTableView.frame
                            unwrappedSelf.view.addSubview(unwrappedSelf.errorGeneralView!)
                            unwrappedSelf.view.bringSubview(toFront: unwrappedSelf.errorGeneralView!)
                        }
                        else {
                            guard let unwrappedSelf = self else { return }
                            unwrappedSelf.errorInternetView = Bundle.main.loadNibNamed("TAPLostConnectErrorView", owner: unwrappedSelf, options: nil)![0] as? TAPLostConnectErrorView
                            unwrappedSelf.errorInternetView?.frame = unwrappedSelf.contentTableView.frame
                            unwrappedSelf.view.addSubview(unwrappedSelf.errorInternetView!)
                            unwrappedSelf.view.bringSubview(toFront: unwrappedSelf.errorInternetView!)
                        }
                    })
                }
                //SVProgressHUD.dismiss()
                TAPGlobal.shared.dismissLoading()
            }
        } else {
            
        }
    }
    
    private func reloadData() {
        contentTableView.reloadData()
    }

}

extension TAPHistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList[section].isCollapsed ? 0 : orderList[section].items.count + 1
    }
    
    func tableView(_ tableView1: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numOfRows = tableView(tableView1, numberOfRowsInSection: indexPath.section)
        let orderModel = orderList[indexPath.section]
        
        if indexPath.row == numOfRows - 1 {
            let cell = tableView1.dequeueReusableCell(withIdentifier: "TAPHistoryOrderInformationTableViewCell", for: indexPath) as! TAPHistoryOrderInformationTableViewCell
            cell.fillData(orderData: orderModel)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView1.dequeueReusableCell(withIdentifier: "TAPHistoryTableViewCell", for: indexPath) as! TAPHistoryTableViewCell
            cell.fillData(orderItem: orderModel.items[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView1: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView1.dequeueReusableHeaderFooterView(withIdentifier: "TAPHistoryHeaderView") as? TAPHistoryHeaderView// ?? TAPHistoryHeaderView(reuseIdentifier: "TAPHistoryHeaderView")
        header?.delegate = self
        header?.section = section
        header?.setCollapsed(orderList[section].isCollapsed)
        header?.fillData(order: orderList[section])
        
        
        if let view = header {
            view.layoutSubviews()
            view.backgroundColor = UIColor.clear
            let rect = CGRect(x: 15, y: 17, width: view.bounds.width - 30, height: view.bounds.height - 17)
            var maskPathTop: UIBezierPath
            if tableView(tableView1, numberOfRowsInSection: section) == 0 {
                maskPathTop = UIBezierPath(roundedRect: rect, cornerRadius: 10.0)
            } else {
                maskPathTop = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
            }
            
            let shapeLayerTop = CAShapeLayer()
            //        shapeLayerTop.frame = view.bounds
            shapeLayerTop.path = maskPathTop.cgPath
            
            shapeLayerTop.lineWidth = 1
            shapeLayerTop.fillColor = UIColor(white: 1, alpha: 1.0).cgColor
            
            shapeLayerTop.name = "shape layer"
            if let subLayers = view.layer.sublayers {
                for sublayer in subLayers {
                    if sublayer.name == "shape layer" {
                        sublayer.removeFromSuperlayer()
                        break
                    }
                }
            }
            
            view.layer.insertSublayer(shapeLayerTop, at: 0)
        }
        return header
    }
}

extension TAPHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 80
    }
    
    func tableView(_ tableView1: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tableView(tableView1, numberOfRowsInSection: indexPath.section) - 1 {
            let order = orderList[indexPath.section]
            if order.orderStatus != "Ready for Pick up" {
                return 155
            }
            return 235
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView1: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        //Top Left Right Corners
//        view.backgroundColor = UIColor.clear
//        let rect = CGRect(x: 15, y: 17, width: view.bounds.width - 30, height: view.bounds.height - 17)
//        var maskPathTop: UIBezierPath
//        if tableView(tableView1, numberOfRowsInSection: section) == 0 {
//            maskPathTop = UIBezierPath(roundedRect: rect, cornerRadius: 10.0)
//        } else {
//            maskPathTop = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
//        }
//
//        let shapeLayerTop = CAShapeLayer()
////        shapeLayerTop.frame = view.bounds
//        shapeLayerTop.path = maskPathTop.cgPath
//
//        shapeLayerTop.lineWidth = 1
//        shapeLayerTop.fillColor = UIColor(white: 1, alpha: 1.0).cgColor
//
//        shapeLayerTop.name = "shape layer"
//
//        view.layer.insertSublayer(shapeLayerTop, at: 0)
    }
    
    func tableView(_ tableView1: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        var maskPathTop: UIBezierPath
        let rect = CGRect(x: 15, y: 0, width: cell.bounds.width - 30, height: cell.bounds.height)
        if indexPath.row == tableView(tableView1, numberOfRowsInSection: indexPath.section) - 1 {
            //Bottom Left Right Corners
            maskPathTop = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
            
        } else {
            maskPathTop = UIBezierPath(rect: rect)
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = maskPathTop.cgPath
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = UIColor(white: 1, alpha: 1.0).cgColor
        
        let bgView = UIView(frame: cell.bounds)
        bgView.backgroundColor = UIColor.clear
        bgView.layer.insertSublayer(shapeLayer, at: 0)
        cell.backgroundView = bgView
    }
}

extension TAPHistoryViewController: TAPHistoryHeaderViewDelegate {
    func toggleSection(_ header: TAPHistoryHeaderView, section: Int) {
        let collapsed = !orderList[section].isCollapsed
        
        // Toggle collapse
        orderList[section].isCollapsed = collapsed
        header.setCollapsed(collapsed)
        
        contentTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}

extension TAPHistoryViewController: TAPHistoryOrderInformationTableViewCellDelegate {
    func historyOrderInformationCellDidTouchConfirm(cell: TAPHistoryOrderInformationTableViewCell) {
        UIAlertController.showAlert(in: self, withTitle: "", message: "Please confirm that you have received your order.", cancelButtonTitle: "Cancel", destructiveButtonTitle: "Confirm", otherButtonTitles: nil) { [weak self] (alertController, alertAction, index) in
            if index != 0 {
                let orderID = "\(cell.orderModel?.id ?? 0)"
                self?.confirmOrder(orderId: orderID)
            }
        }
    }
    
    func historyOrderInformationCellDidTouchReport(cell: TAPHistoryOrderInformationTableViewCell) {
        let vc = TAPHistoryReportIssueViewController(nibName: "TAPHistoryReportIssueViewController", bundle: nil)
        vc.orderId = "\(cell.orderModel?.id ?? 0)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func historyOrderInformationCellDidTouchVisitShop(cell: TAPHistoryOrderInformationTableViewCell) {
        let vc = TAPStorePageViewController(nibName: "TAPStorePageViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func confirmOrder(orderId: String) {
        //SVProgressHUD.show()
        TAPGlobal.shared.showLoading()
        let apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/orders/\(orderId)/complete"
        
        TAPWebservice.shareInstance.sendPOSTRequest(path: apiPath, params: [:], responseObjectClass: TAPHistoryModel()) { [weak self] (success, responseEntity) in
            //SVProgressHUD.dismiss()
            TAPGlobal.shared.dismissLoading()
            guard let strongSelf = self else {
                return
            }
            let message = success ? "We hope you like your purchase(s)" : "Failed. Please try again and if persists, contact Tapiver team."
            UIAlertController.showAlert(in: strongSelf, withTitle: "", message: message, cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: nil)
        }
    }
}
