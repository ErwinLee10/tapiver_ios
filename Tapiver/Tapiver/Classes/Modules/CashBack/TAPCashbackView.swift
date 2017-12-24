//
//  TAPCashbackView.swift
//  Tapiver
//
//  Created by Hung vu on 12/24/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD

class TAPCashbackView: UIViewController {
    @IBOutlet weak var lbEmptyCashback: UILabel!
    
    @IBOutlet weak var lbCostRedeem: UILabel!
    @IBOutlet weak var btViewDetals: UIButton!
    @IBOutlet weak var headerView: TAPHeaderView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btReddem: UIButton!
    
    public var cashBacks: TAPListCashback?
    private var isLoadData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIB()
        initData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isLoadData {
            initData()
        }
    }
    private func initIB() {
        self.headerView.delegate = self
        self.tableview.register(UINib.init(nibName: "TAPCashbackCell", bundle: nil), forCellReuseIdentifier: "TAPCashbackCell")
    }
    private func initData() {
        if cashBacks != nil {
            cashBacks = TAPListCashback()
        }
        callApi()
    }
    func callApi() {
        var apiPath: String
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = API_PATH(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/cashback")
        }else {
            apiPath = TAPConstants.APIPath.overview
        }
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        header.setValue(TAPGlobal.shared.getLoginModel()?.webSessionId ?? "", forKey: "Authorization")
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: nil, headers: header, responseObjectClass: TAPListCashback()) { (success, response) in
            if success {
                self.isLoadData = true
                guard let model = response as? TAPListCashback else {
                    return
                }
                self.cashBacks = model
//                self.cashBacks = TAPListCashback()
//                let dict = self.convertToDictionary(text: "")
//                self.cashBacks?.parserResponse(dic: dict! as NSDictionary)
                self.paserData()
            } else {
                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
            }
            SVProgressHUD.dismiss()
        }
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        let text1 = """
        {
        "earning": 353.45,
        "redeemable": 22,
        "redeemed": 353.45,
        "pending": 13.2,
        "processing": 0,
        "cashbacks": [
        {
        "id": 48,
        "orderDate": 1507332130117,
        "cashbackPercentage": 5,
        "cashbackAmount": 83.25,
        "status": "REDEEMED",
        "orderId": 315073609301
        },
        {
        "id": 47,
        "orderDate": 1507331358703,
        "cashbackPercentage": 5,
        "cashbackAmount": 9.25,
        "status": "PENDING",
        "orderId": 315073601581
        }
        ]
        }
        """
        if let data = text1.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    @IBAction func acRedeem(_ sender: Any) {
        let redeemView = TAPRedeemRequest.init(frame: WINDOW!.frame)
        redeemView.delegate = self
        UIApplication.shared.keyWindow?.addSubview(redeemView)
    }

    private func paserData() {
        if let count = self.cashBacks?.redeemable {
            if count > 20 {
                self.btReddem.isEnabled = true
                self.lbEmptyCashback.isHidden = true
                self.btReddem.setTitle("REDEEM CASHBACK", for: .normal)
                self.btReddem.backgroundColor = UIColor.init(netHex: 0x1CAAB6)
            }else {
                self.btReddem.setTitle("MIN S$20 TO REDEEM", for: .normal)
                self.lbEmptyCashback.isHidden = false
                self.btReddem.backgroundColor = UIColor.init(netHex: 0x848585)
                self.btReddem.isEnabled = false
            }
            self.lbCostRedeem.text = "$\(count)"
        }
        
        self.tableview.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension TAPCashbackView: TAPHeaderViewDelegate {
    func headerViewDidTouchBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension TAPCashbackView : TAPRedeemRequestDelegate {
    func reloadData() {
        initIB()
    }
    
    
}
extension TAPCashbackView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cashItems = self.cashBacks?.cashBacks.count else {
            return 0
            
        }
        return cashItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPCashbackCell") as? TAPCashbackCell else {
            return UITableViewCell()
        }
        guard let cardItems = self.cashBacks?.cashBacks[indexPath.row] else {
            return UITableViewCell()
            
        }
        cell.setData(cashback: cardItems)
        return cell
    }
}
extension TAPCashbackView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPSubShippingMethod") as? TAPSubShippingMethod else {
            return nil
        }
        cell.viewHeader.isHidden = false
        cell.lbHeader.text = "Review Order"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
