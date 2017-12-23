//
//  TAPFeedViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD

class TAPFeedViewController: TAPBaseViewController  {

    private var feedsApiModels: TAPFeedApiModel?
    @IBOutlet private weak var tableData: UITableView!
    @IBOutlet private weak var nodataView: UIView!
    
    var errorInternetView: TAPLostConnectErrorView?
    var errorGeneralView: TAPGeneralErrorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableData.register(UINib.init(nibName: "TAPFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPFeedTableViewCell")
        (headerView as? TAPMainPageHeaderView)?.delegate = self
        self.getData()
    }
    
    private func getData() {
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        header.setValue(TAPGlobal.shared.getLoginModel()?.webSessionId ?? "", forKey: "Authorization")
        let params = NSMutableDictionary()
        var apiPath: String
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = API_PATH(path: String.init(format: "/api/v1/u/%@/feeds", TAPGlobal.shared.getLoginModel()?.userId ?? ""))
            //params.setValue((0), forKey: "page")
        } else {
            apiPath = API_PATH(path: String.init(format: "/api/v1/s/overview", TAPGlobal.shared.getLoginModel()?.userId ?? ""))
            //params.setValue((0), forKey: "page")
            //params.setValue((0), forKey: "q")
            //params.setValue((0), forKey: "landmarkId")
            //params.setValue((0), forKey: "userId")
        }
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params, headers: header, responseObjectClass: TAPFeedApiModel()) { (success, response) in
            if success {
                guard let model = response as? TAPFeedApiModel else {
                    return
                }
                self.feedsApiModels = model
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
//                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
            }
            SVProgressHUD.dismiss()
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
        TAPMainFrame.getNavi().pushViewController(vc, animated: true)
    }
    
    func tapIteamAt(index: NSIndexPath, indexItem: NSIndexPath) {
        
    }
}
