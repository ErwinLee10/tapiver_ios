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
        
        let params: [String: Any] = [:]
        var apiPath: String
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/feeds"
        } else {
            apiPath = TAPConstants.APIPath.overview
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
                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: strongSelf)
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

