//
//  TAPEmailChangeView.swift
//  Tapiver
//
//  Created by admin on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation
//import SVProgressHUD

protocol TAPEmailChangeViewDelegate {
    func updateEmail(email: String)
}

class TAPEmailChangeView: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    var delegate: TAPEmailChangeViewDelegate?
    
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = email
//        edgesForExtendedLayout = []
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//
//        let backButton = UIBarButtonItem()
//        backButton.title = ""
//        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    public func isEmail() -> Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return (emailTextField.text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                      options: String.CompareOptions.regularExpression,
                      range: nil, locale: nil) != nil)
    }
    @IBAction func updateEmailButtonTap(_ sender: UIButton) {
        if isEmail() == false {
            //SVProgressHUD.showError(withStatus: "Email is not valid")
            TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "Email is not valid", message: "", positive: "OK", positiveHandler: nil, vc: self)
            return
        }
        
        TAPWebservice.shareInstance.sendPUTRequest(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/email", parameters: ["email": emailTextField.text!]) { (check) in
            if check {
                self.delegate?.updateEmail(email: self.emailTextField.text!)
                self.navigationController?.popViewController(animated: true)
            }
            else {
                TAPDialogUtils.shareInstance.showAlertMessageOneButton(title: "", message: "Server error, please contact Tapiver team for assistance", positive: "OK", positiveHandler: nil, vc: self)
            }
        }
    }
    @IBAction func backButtonTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
