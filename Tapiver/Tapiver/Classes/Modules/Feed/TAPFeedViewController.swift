//
//  TAPFeedViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD

class TAPFeedViewController: UIViewController  {

    private var feedsApiModels: TAPFeedApiModel?
    @IBOutlet private weak var tableData: UITableView!
    @IBOutlet private weak var nodataView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableData.register(UINib.init(nibName: "TAPFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPFeedTableViewCell")
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
                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
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
        cell.fillDataToView(model: data.feedModels[indexPath.row])
        return cell
    }
    
    
}

