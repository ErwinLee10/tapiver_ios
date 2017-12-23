//
//  TAPLandMarkView.swift
//  Tapiver
//
//  Created by HungVT on 12/15/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD

@objc protocol TAPLandMarkViewDelegate: class{
    func landMarkSelectAt(index :Int, isSelect:Bool)
    
}

class TAPLandMarkView: UIView {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sView: UIView!
    @IBOutlet var viewSup: UIControl!
    weak var delegate: TAPLandMarkViewDelegate?
    var listData: [TAPLandmarkModel]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("TAPLandMarkView", owner: self, options: nil)
        viewSup.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        addSubview(viewSup)
        sView.frame = CGRect(x: -frame.size.width - 100.0 , y: 0, width: frame.size.width, height: frame.size.height)
        viewSup.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        initIB()
        initData()
        animation(withFrame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initIB()
    }
    private func animation(withFrame: CGRect) {
        UIView.animate(withDuration: 0.4) {
            self.sView.frame = CGRect(x:0, y: self.sView.frame.origin.y, width: withFrame.size.width, height: withFrame.size.height)
        }
        
    }
    private func initIB() {
        self.tableView.register(UINib.init(nibName: "TAPCategoryLever2Cell", bundle: nil), forCellReuseIdentifier: "TAPCategoryLever2Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    public func initData() {
        callApi()
    }
    // MARK: IBAction
    @IBAction func tapView(_ sender: Any) {
        dissmiss(isSelect: false, index: -1)
    }
    func dissmiss(isSelect: Bool, index: Int){
        if self.delegate == nil {
            return
        }
        delegate?.landMarkSelectAt(index: index, isSelect:isSelect)
        UIView.animate(withDuration: 0.4, animations: {
            self.sView.frame = CGRect(x: -self.sView.frame.size.width, y: self.sView.frame.origin.y, width: self.sView.frame.size.width, height: self.sView.frame.size.height)
        }) { (isSuccess) in
              self.diss()
        }
        
        // Show mall page
        if isSelect {
            self.showMallPage(at: index)
        }
    }
    
    func diss() {
        self.removeFromSuperview()
    }
    
    // MARK: Api
    
    private func callApi() {
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        header.setValue(TAPGlobal.shared.getLoginModel()?.webSessionId ?? "", forKey: "Authorization")
        let params = NSMutableDictionary()
        var apiPath: String
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = API_PATH(path: String.init(format: "/api/v1/landmark", TAPGlobal.shared.getLoginModel()?.userId ?? ""))
        } else {
            apiPath = API_PATH(path: String.init(format: "/api/v1/s/overview", TAPGlobal.shared.getLoginModel()?.userId ?? ""))
        }
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params, headers: header, responseObjectClass: TAPListLandMark()) { (success, response) in
            if success {
                guard let model = response as? TAPListLandMark else {
                    return
                }
                self.listData = model.listLandMark
                self.tableView.reloadData()
            } else {
            }
            SVProgressHUD.dismiss()
        }
    }
    
    private func showMallPage(at index: Int) {
        guard let listdata = self.listData, index > 0 else {
            return  
        }
        // Show Mall page
        let landmark = listdata[index]
        let mallPage = TAPMallPageTabBarViewController.mallPageTabBarController(landmark: landmark)
        TAPMainFrame.getNavi().pushViewController(mallPage, animated: true)
    }
}
extension TAPLandMarkView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dissmiss(isSelect: true, index: indexPath.row)
    }
    
}
extension TAPLandMarkView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counts:Int = listData?.count else {
            return 0
        }
        return counts
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPCategoryLever2Cell", for: indexPath) as? TAPCategoryLever2Cell else {
            return UITableViewCell()
        }
        guard let item = listData?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.typeLever = TAPCategoryLever2CellType.LandMark
        cell.setIB()
        cell.lbNameMenu2.text = item.name
        return cell
    }
    
    
    
    
}
