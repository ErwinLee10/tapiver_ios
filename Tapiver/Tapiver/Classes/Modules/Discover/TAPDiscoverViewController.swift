//
//  TAPDiscoverViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPDiscoverViewController: TAPBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    private var feedsApiModels: TAPFeedApiModel?
    public var landMarkId :String?
    var isLoadMore: Bool = false
    
    var errorInternetView: TAPLostConnectErrorView?
    var errorGeneralView: TAPGeneralErrorView?
    
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
        //params.setValue(landMarkId ?? "" , forKey: "landMarkId")
        params.setValue(self.feedsApiModels?.feedModels.count , forKey: "page")
		
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = API_PATH(path: "/api/v1/discover")
			params.setValue(TAPGlobal.shared.getLoginModel()?.userId ?? "", forKey: "userId")
        } else {
            apiPath = API_PATH(path: "/api/v1/s/overview")
        }
        //SVProgressHUD.show()
        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params, headers: header, responseObjectClass: TAPFeedApiModel()) { (success, response) in
            if success {
                guard let model = response as? TAPFeedApiModel else {
                    return
                }
                self.feedsApiModels = model
                self.tableView.reloadData()
            } else {
                TAPWebservice.shareInstance.checkHaveInternet(response: { (check) in
                    if check {
                        //server error
                        self.errorGeneralView = Bundle.main.loadNibNamed("TAPGeneralErrorView", owner: self, options: nil)![0] as? TAPGeneralErrorView
                        self.errorGeneralView?.frame = self.tableView.frame
                        self.view.addSubview(self.errorGeneralView!)
                        self.view.bringSubview(toFront: self.errorGeneralView!)
                    }
                    else {
                        self.errorInternetView = Bundle.main.loadNibNamed("TAPLostConnectErrorView", owner: self, options: nil)![0] as? TAPLostConnectErrorView
                        self.errorInternetView?.frame = self.tableView.frame
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
        let vc = TAPStorePageViewController(nibName: "TAPStorePageViewController", bundle: nil)
//        let feedModel = TAPFeedModel.init()
//        feedModel.sellerPicture = data?.sellerPicture
//        feedModel.sellerName = data?.sellerName
//        feedModel.sellerTotalFollower = data?.sellerTotalFollower
//        //feedModel.sellerCoverPicture = data.sellerc
//        feedModel.sellerId = Int(data?.sellerId ?? "0")
//        feedModel.sellerAddress = data?.sellerAddress
        vc.feedModel = self.feedsApiModels?.feedModels[row]
        TAPMainFrame.getNavi().pushViewController(vc, animated: true)
    }
    
    func tapIteamAt(index: IndexPath, item: TAPProductModel) {
        let productViewController: TAPProductMainPageViewController = TAPProductMainPageViewController(nibName: "TAPProductMainPageViewController", bundle: nil)
        productViewController.setData(id: item.id!, title: (self.feedsApiModels?.feedModels[index.row].sellerName)!)
        TAPMainFrame.getNavi().pushViewController(productViewController, animated: true)
    }
    
    func followShop(at row: Int) {
		if TAPGlobal.shared.hasLogin() == false {
			TAPMainFrame.showLoginPageMain()
			return
		}
		
		
        if self.feedsApiModels?.feedModels[row].isFollowedByThisUser == true {
            TAPWebservice.shareInstance.sendDELETERequest(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/follow/\(self.feedsApiModels?.feedModels[row].sellerId ?? 0)", responseHandler: { (check, response) in
                if check {
                    self.feedsApiModels?.feedModels[row].sellerTotalFollower = response as? Int
                    
                    if self.feedsApiModels?.feedModels[row].isFollowedByThisUser == true {
                        self.feedsApiModels?.feedModels[row].isFollowedByThisUser = false
                    }
                    else {
                        self.feedsApiModels?.feedModels[row].isFollowedByThisUser = true
                    }
                    
                    let indexPath = IndexPath(item: row, section: 0)
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                }
                else {
                    TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
                }
            })
        }
        else {
            TAPWebservice.shareInstance.sendPOSTRequest(path: API_PATH(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/follow/\(self.feedsApiModels?.feedModels[row].sellerId ?? 0)"), params: [:]) { (check, response) in
                if check {
                    self.feedsApiModels?.feedModels[row].sellerTotalFollower = response
                    
                    if self.feedsApiModels?.feedModels[row].isFollowedByThisUser == true {
                        self.feedsApiModels?.feedModels[row].isFollowedByThisUser = false
                    }
                    else {
                        self.feedsApiModels?.feedModels[row].isFollowedByThisUser = true
                    }
                    
                    let indexPath = IndexPath(item: row, section: 0)
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                }
                else {
                    TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
                }
            }
        }
    }
}
