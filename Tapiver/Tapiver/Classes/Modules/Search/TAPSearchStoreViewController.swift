//
//  TAPSearchStoreViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/24/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
//import SVProgressHUD

class TAPSearchStoreViewController: UIViewController {
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    var feedModelList: [TAPFeedModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        contentTableView.register(UINib.init(nibName: "TAPFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPFeedTableViewCell")
        emptyView.isHidden = true
    }
    
    private func reloadData() {
        if feedModelList.count > 0 {
            emptyView.isHidden = true
            contentTableView.isHidden = false
            contentTableView.reloadData()
        } else {
            emptyView.isHidden = false
            contentTableView.isHidden = true
        }
    }
    
    func search(with keyword: String) {
        
        let apiPath = TAPConstants.APIPath.discover
        var params: [String: Any] = [:]
        // TODO: keyword
        if TAPGlobal.shared.hasLogin(), let userID = TAPGlobal.shared.getLoginModel()?.userId {
            params[TAPConstants.APIParams.userId] = userID.numberValue?.intValue ?? 0
        }
        
        //SVProgressHUD.show()
        TAPGlobal.shared.showLoading()
        
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params, responseObjectClass: TAPFeedApiModel()) { [weak self] (success, response) in
            guard let strongSelf = self else {
                //SVProgressHUD.dismiss()
                TAPGlobal.shared.dismissLoading()
                return
            }
            
            if success, let model = response as? TAPFeedApiModel {
                strongSelf.feedModelList = model.feedModels
                strongSelf.reloadData()
            } else {
                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: strongSelf)
            }
            //SVProgressHUD.dismiss()
            TAPGlobal.shared.dismissLoading()
        }
    }

}

extension TAPSearchStoreViewController: UITableViewDataSource {
    
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

extension TAPSearchStoreViewController: UITableViewDelegate {
    
}

extension TAPSearchStoreViewController: TAPFeedTableViewCellDelegate {
    func tapShop(at row: Int) {
        let vc = TAPStorePageViewController(nibName: "TAPStorePageViewController", bundle: nil)
        vc.feedModel = feedModelList[row]
        TAPMainFrame.getNavi().pushViewController(vc, animated: true)
    }
    
    func tapIteamAt(index: IndexPath, item: TAPProductModel) {
        let productViewController: TAPProductMainPageViewController = TAPProductMainPageViewController(nibName: "TAPProductMainPageViewController", bundle: nil)
        productViewController.setData(id: item.id ?? "", title: feedModelList[index.row].sellerName ?? "")
        TAPMainFrame.getNavi().pushViewController(productViewController, animated: true)
    }
}
