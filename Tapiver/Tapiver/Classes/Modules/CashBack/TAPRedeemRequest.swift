//
//  TAPRedeemRequest.swift
//  Tapiver
//
//  Created by Hung vu on 12/24/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import DropDown

@objc protocol TAPRedeemRequestDelegate: class {
    @objc func reloadData()
}
class TAPRedeemRequest: UIView,UITextFieldDelegate {
    @IBOutlet var containerView: UIControl!
    @IBOutlet weak var tfBankNumber: UITextField!
    @IBOutlet weak var tfBankName: UITextField!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var btInputBankName: UIButton!
    @IBOutlet weak var dropView: UIView!
    
    private var drop = DropDown()
    public weak var delegate: TAPRedeemRequestDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("TAPRedeemRequest", owner: self, options: nil)
        addSubview(self.containerView)
        self.containerView.frame = CGRect(x:0, y:0, width:frame.width, height: frame.height)
        self.containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        initIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initIB() {
        IQKeyboardManager.sharedManager().enable = true
        drop.dismissMode = .onTap
    }
    private func createDrop() {
        drop.anchorView = dropView
        drop.dataSource = ["DBS","POSB","UOB","OCBC","Citibank ","Maybank","HSBC"]
        drop.cellNib = UINib(nibName: "TAPAddToCartDropViewCell1", bundle: nil)
        drop.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? TAPAddToCartDropViewCell1 else { return }
            cell.detailTextLabel?.text =  "• \(item)"
            cell.colorView.isHidden = true
        }
        drop.selectionAction = { [unowned self] (index: Int, item: String) in
            print("index>>>> \(index)")
            self.tfBankName.text = item
        }
        drop.show()
    }
    private func postData() {
        var apiPath: String
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = API_PATH(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/cashback/redemption")
        }else {
            apiPath = TAPConstants.APIPath.overview
        }
        let params = [
            "bankName" : self.tfBankName.text ?? "",
            "accountNo" : self.tfBankNumber.text ?? "",
            "name": self.tfFullName.text ?? ""
        ]
        print("params \(params)")
        let header = NSMutableDictionary()
        header.setValue("application/json", forKey: "Content-Type")
        header.setValue(TAPGlobal.shared.getLoginModel()?.webSessionId ?? "", forKey: "Authorization")
        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendPOSTRequest(path: apiPath, params: params as NSDictionary, headers: nil, responseObjectClass: TAPBaseEntity()) { (isSucess, response) in
            if isSucess {
                if self.delegate != nil {
                    self.delegate?.reloadData()
                }
                self.removeFromSuperview()
            }else {
                
            }
            TAPGlobal.shared.dismissLoading()
        }
    }
    
    @IBAction func AcSend(_ sender: Any) {
        postData()
    }
    
    @IBAction func acinputBankName(_ sender: Any) {
        createDrop()
    }
    @IBAction func acDissmiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}
