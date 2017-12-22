//
//  TAPDiscoverViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD

class TAPDiscoverViewController: TAPBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    private var feedsApiModels: TAPFeedApiModel?
    public var landMarkId :String?
    var isLoadMore: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIB()
        initData()
    }
 
    func initIB() {
        (self.headerView as? TAPMainPageHeaderView)?.delegate = self
        self.tableView.register(UINib.init(nibName: "TAPFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPFeedTableViewCell")
    }
    func initData() {
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        header.setValue(TAPGlobal.shared.getLoginModel()?.webSessionId ?? "", forKey: "Authorization")
        let params = NSMutableDictionary()
        var apiPath: String
        params.setValue(landMarkId ?? "" , forKey: "landMarkId")
        params.setValue(self.feedsApiModels?.feedModels.count , forKey: "page")
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = API_PATH(path: String.init(format: "/api/v1/discover", TAPGlobal.shared.getLoginModel()?.userId ?? ""))
        } else {
            apiPath = API_PATH(path: String.init(format: "/api/v1/s/overview", TAPGlobal.shared.getLoginModel()?.userId ?? ""))
        }
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params, headers: header, responseObjectClass: TAPFeedApiModel()) { (success, response) in
            if success {
                guard let model = response as? TAPFeedApiModel else {
                    return
                }
                self.feedsApiModels = model
                self.tableView.reloadData()
            } else {
                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
            }
            SVProgressHUD.dismiss()
        }
    }
    func tapIteamAt(index: NSIndexPath, indexItem: NSIndexPath) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
extension TAPDiscoverViewController: UITableViewDelegate {
    
}

extension TAPDiscoverViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = self.feedsApiModels else {
            return 0
        }
        return data.feedModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = self.feedsApiModels else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPFeedTableViewCell", for: indexPath) as? TAPFeedTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.row = indexPath.row
        cell.typeView = MainPageViewType.MainPageViewTypeDiscover
        cell.fillDataToView(model: data.feedModels[indexPath.row])
        return cell
    }
    
}

extension TAPDiscoverViewController: TAPMainPageHeaderViewDelegate {
    func headerViewDidTouchMenu() {
        showRightMenu()
    }
}

extension TAPDiscoverViewController: TAPFeedTableViewCellDelegate {
    func tapShop(at row: Int) {
        
    }
    
    func tapIteamAt(index: IndexPath, item: TAPProductModel) {
        let productViewController: TAPProductMainPageViewController = TAPProductMainPageViewController(nibName: "TAPProductMainPageViewController", bundle: nil)
        productViewController.setData(id: item.id!, title: (self.feedsApiModels?.feedModels[index.row].sellerName)!)
        self.present(productViewController, animated: true) {
            
        }
    }
}
