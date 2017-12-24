//
//  TAPMallPageShopViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/11/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD

class TAPMallPageShopViewController: TAPMallPageBaseViewController {
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var contentTableView: UITableView!
    var feedModelList: [TAPFeedModel] = []
    
    var errorInternetView: TAPLostConnectErrorView?
    var errorGeneralView: TAPGeneralErrorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    override func setupView() {
        super.setupView()
        (headerView as? TAPHeaderView)?.delegate = self
        contentTableView.register(UINib.init(nibName: "TAPFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPFeedTableViewCell")
    }
    
    private func reloadData() {
        if feedModelList.count > 0 {
            noDataView.isHidden = true
            contentTableView.isHidden = false
            contentTableView.reloadData()
        } else {
            noDataView.isHidden = false
            contentTableView.isHidden = true
        }
    }
    
    private func getData() {
        let apiPath = TAPConstants.APIPath.discover
        var params: [String: Any] = [:]
        if let landmarkId = landmark?.id {
            params[TAPConstants.APIParams.landmarkId] = landmarkId
        }
        if TAPGlobal.shared.hasLogin(), let userID = TAPGlobal.shared.getLoginModel()?.userId {
            params[TAPConstants.APIParams.userId] = userID.numberValue?.intValue ?? 0
        }
        
        SVProgressHUD.show()
        
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params, responseObjectClass: TAPFeedApiModel()) { [weak self] (success, response) in
            guard let strongSelf = self else {
                SVProgressHUD.dismiss()
                return
            }
            
            if success, let model = response as? TAPFeedApiModel {
                strongSelf.feedModelList = model.feedModels
                strongSelf.reloadData()
            } else {
                TAPWebservice.shareInstance.checkHaveInternet(response: { (check) in
                    if check {
                        //server error
                        guard let unwrappedSelf = self else { return }
                        unwrappedSelf.errorGeneralView = Bundle.main.loadNibNamed("TAPGeneralErrorView", owner: unwrappedSelf, options: nil)![0] as? TAPGeneralErrorView
                        unwrappedSelf.errorGeneralView?.frame = unwrappedSelf.noDataView.frame
                        unwrappedSelf.view.addSubview(unwrappedSelf.errorGeneralView!)
                        unwrappedSelf.view.bringSubview(toFront: unwrappedSelf.errorGeneralView!)
                    }
                    else {
                        guard let unwrappedSelf = self else { return }
                        unwrappedSelf.errorInternetView = Bundle.main.loadNibNamed("TAPLostConnectErrorView", owner: unwrappedSelf, options: nil)![0] as? TAPLostConnectErrorView
                        unwrappedSelf.errorInternetView?.frame = unwrappedSelf.noDataView.frame
                        unwrappedSelf.view.addSubview(unwrappedSelf.errorInternetView!)
                        unwrappedSelf.view.bringSubview(toFront: unwrappedSelf.errorInternetView!)
                    }
                })
//                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: strongSelf)
            }
            SVProgressHUD.dismiss()
        }
    }

}

extension TAPMallPageShopViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedModelList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TAPFeedTableViewCell", for: indexPath) as! TAPFeedTableViewCell
        cell.delegate = self
        cell.row = indexPath.row
        cell.fillDataToView(model: feedModelList[indexPath.row])
        return cell
    }
    
}

extension TAPMallPageShopViewController: UITableViewDelegate {
    
}

extension TAPMallPageShopViewController: TAPHeaderViewDelegate {
    func headerViewDidTouchBack() {
        
    }
    
    func headerViewDidTouchSearch() {
        
    }
    
    func headerViewDidTouchCart() {
        
    }
    
    func headerViewDidTouchMenu() {
        showRightMenu()
    }
}

extension TAPMallPageShopViewController: TAPFeedTableViewCellDelegate {
    func tapShop(at row: Int) {
        let vc = TAPStorePageViewController(nibName: "TAPStorePageViewController", bundle: nil)
        vc.feedModel = feedModelList[row]
        TAPMainFrame.getNavi().pushViewController(vc, animated: true)
    }
    
    func tapIteamAt(index: IndexPath, item: TAPProductModel) {
        openProductPage(product: item, feedModel: feedModelList[index.row])
    }
}

