//
//  TAPFeedViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
//import SVProgressHUD

class TAPFeedViewController: TAPBaseViewController  {

    private var feedsApiModels: TAPFeedApiModel?
    @IBOutlet private weak var tableData: UITableView!
    @IBOutlet private weak var nodataView: UIView!
    
    var errorInternetView: TAPLostConnectErrorView?
    var errorGeneralView: TAPGeneralErrorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIB()
        self.getData(typeLoad: Table.none)
    }
    
    private func initIB() {
        tableData.register(UINib.init(nibName: "TAPFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPFeedTableViewCell")
        (headerView as? TAPMainPageHeaderView)?.delegate = self
        self.makePullToRefresh(tableName: tableData)
    }
    
    @objc override public func refreshData() {
        getData(typeLoad: Table.refresh)
    }
    
    private func getData(typeLoad: Table) {
		if TAPGlobal.shared.hasLogin() == false {
			self.nodataView.isHidden = false
			return
		}

        var page: Int = 0
        if self.feedsApiModels == nil || typeLoad == Table.none || typeLoad == Table.refresh {
            self.feedsApiModels = TAPFeedApiModel()
            self.isMoreData = true
        }
        if typeLoad == Table.loadmore {
            page = (self.feedsApiModels?.feedModels.count)!
        }
        
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        header.setValue(TAPGlobal.shared.getLoginModel()?.webSessionId ?? "", forKey: "Authorization")
        let params = NSMutableDictionary()
		var apiPath = API_PATH(path: String.init(format: "/api/v1/u/%@/feeds", TAPGlobal.shared.getLoginModel()?.userId ?? ""))
        params.setValue(page, forKey: "page")

        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params, headers: header, responseObjectClass: TAPFeedApiModel()) { [unowned self] (success, response) in
            if success {
                guard let model = response as? TAPFeedApiModel else {
                    return
                }
                if  typeLoad == Table.loadmore  {
                    if model.feedModels.count > 0 {
                        for item in model.feedModels {
                            self.feedsApiModels?.feedModels .append(item)
                        }
                    } else {
                        self.isMoreData = false
                    }
                }else {
                    self.feedsApiModels = model
                    self.endRefresh()
                }
                
                self.tableData.reloadData()
                
                guard let data = self.feedsApiModels else {
                    return
                }
                self.nodataView.isHidden = data.feedModels.count > 0
            } else {
                TAPWebservice.shareInstance.checkHaveInternet(response: { (check) in
                    if check {
                        //server error
                        self.errorGeneralView = Bundle.main.loadNibNamed("TAPGeneralErrorView", owner: self, options: nil)![0] as? TAPGeneralErrorView
                        self.errorGeneralView?.frame = self.nodataView.frame
                        self.view.addSubview(self.errorGeneralView!)
                        self.view.bringSubview(toFront: self.errorGeneralView!)
                    }
                    else {
                        self.errorInternetView = Bundle.main.loadNibNamed("TAPLostConnectErrorView", owner: self, options: nil)![0] as? TAPLostConnectErrorView
                        self.errorInternetView?.frame = self.nodataView.frame
                        self.view.addSubview(self.errorInternetView!)
                        self.view.bringSubview(toFront: self.errorInternetView!)
                    }
                })

            }
            TAPGlobal.shared.dismissLoading()
        }
        
        // get cart number
		if ((TAPGlobal.shared.getLoginModel()?.userId) != nil) {
			apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/cart"
			TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: [:], responseObjectClass: TAPCartListModel()) { (success, responseEntity) in
				if success, let cartListModel = responseEntity as? TAPCartListModel {
					var number = 0
					for item in cartListModel.cartItemsPerSeller {
						for product in item.productVariations {
							if (product.quantity != nil) {
								number += product.quantity!
							}
						}
					}
					
					NotificationCenter.default.post(name:Notification.Name(rawValue:TAPConstants.NotificationName.ChangeCartNumber), object: ["number": String(number)])
				} else {
					
				}
			}
		}
    }
}

extension TAPFeedViewController: UITableViewDelegate {
    
}

extension TAPFeedViewController: UITableViewDataSource {
    
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
        cell.fillDataToView(model: data.feedModels[indexPath.row])
        if indexPath.row == self.feedsApiModels!.feedModels.count - 1 && self.isMoreData == true {
            getData(typeLoad: Table.loadmore)
        }
        return cell
    }
    
    
}

extension TAPFeedViewController: TAPMainPageHeaderViewDelegate {
    
    func headerViewDidTouchMenu() {
        showRightMenu()
    }
    
    func headerViewDidTouchSearch() {
        
    }
}

extension TAPFeedViewController: TAPFeedTableViewCellDelegate {
    func tapShop(at row: Int) {
        let vc = TAPStorePageViewController(nibName: "TAPStorePageViewController", bundle: nil)
        vc.feedModel = feedsApiModels?.feedModels[row]
        TAPMainFrame.getNavi().pushViewController(vc, animated: true)
    }
    
    func tapIteamAt(index: IndexPath, item: TAPProductModel) {
        let productViewController: TAPProductMainPageViewController = TAPProductMainPageViewController(nibName: "TAPProductMainPageViewController", bundle: nil)
        productViewController.setData(id: item.id!, title: (self.feedsApiModels?.feedModels[index.row].sellerName)!)
        TAPMainFrame.getNavi().pushViewController(productViewController, animated: true)
    }
    
    func followShop(at row: Int) {
        TAPWebservice.shareInstance.sendDELETERequest(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/follow/\(self.feedsApiModels?.feedModels[row].sellerId ?? 0)", responseHandler: { (check, response) in
            if check {
                self.feedsApiModels?.feedModels.remove(at: row)
                
                self.tableData.reloadData()
            }
            else {
                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
            }
        })
    }
}
