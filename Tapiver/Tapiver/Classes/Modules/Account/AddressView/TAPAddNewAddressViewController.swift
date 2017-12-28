//
//  TAPAddNewAddressViewController.swift
//  Tapiver
//
//  Created by admin on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AMPopTip

protocol TAPAddNewAddressViewControllerDelegate {
    func addAddress(address: TAPProfileAddressModel)
}

class TAPAddNewAddressViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var floorTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    
    @IBOutlet weak var nameErrorImage: UIImageView!
    @IBOutlet weak var contactErrorImage: UIImageView!
    @IBOutlet weak var streetErrorImage: UIImageView!
    @IBOutlet weak var postalErrorImage: UIImageView!
    
    var kbHeight: CGFloat!
    
    let popTip = PopTip()
    
    var delegate: TAPAddNewAddressViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //IQKeyboardManager.sharedManager().enable = true
        
//        let backButton = UIBarButtonItem()
//        backButton.title = ""
//        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.nameTextField.returnKeyType = .next
        self.contactNumberTextField.returnKeyType = .next
        self.streetTextField.returnKeyType = .next
        self.floorTextField.returnKeyType = .next
        self.unitTextField.returnKeyType = .next
        self.postalCodeTextField.returnKeyType = .done
        
        nameTextField.keyboardType = .namePhonePad
        contactNumberTextField.keyboardType = .phonePad
        floorTextField.keyboardType = .numberPad
        unitTextField.keyboardType = .numberPad
        postalCodeTextField.keyboardType = .numberPad
        
        nameErrorImage.alpha = 0
        contactErrorImage.alpha = 0
        streetErrorImage.alpha = 0
        postalErrorImage.alpha = 0
        
        nameTextField.delegate = self
        contactNumberTextField.delegate = self
        streetTextField.delegate = self
        floorTextField.delegate = self
        unitTextField.delegate = self
        postalCodeTextField.delegate = self
        
        edgesForExtendedLayout = []
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidPress(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        switch textField
        {
        case nameTextField:
            contactNumberTextField.becomeFirstResponder()
            break
        case contactNumberTextField:
            streetTextField.becomeFirstResponder()
            break
        case streetTextField:
            floorTextField.becomeFirstResponder()
            break
        case floorTextField:
            unitTextField.becomeFirstResponder()
            break
        case unitTextField:
            postalCodeTextField.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
            break
        }
        return true
    }
    
    @objc func keyBoardDidPress(notification: NSNotification) {
        if popTip.isVisible {
            if (nameTextField.text?.isEmpty)! {
                nameErrorImage.alpha = 1
            } else {
                nameErrorImage.alpha = 0
            }
            if (contactNumberTextField.text?.isEmpty)! {
                contactErrorImage.alpha = 1
            } else {
                contactErrorImage.alpha = 0
            }
            if (streetTextField.text?.isEmpty)! {
                streetErrorImage.alpha = 1
            } else {
                streetErrorImage.alpha = 0
            }
            if (postalCodeTextField.text?.isEmpty)! {
                postalErrorImage.alpha = 1
            } else {
                postalErrorImage.alpha = 0
            }
        }
        popTip.hide()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.nameTextField {
            if nameErrorImage.alpha == 1 {
                popTip.show(text: "This field cannot be blank", direction: .down, maxWidth: 200, in: self.view, from: nameErrorImage.frame)
                popTip.bubbleColor = .black
                popTip.shouldDismissOnTap = true
            }
        }
        else if textField == self.contactNumberTextField {
            if contactErrorImage.alpha == 1 {
                popTip.show(text: "This field cannot be blank", direction: .down, maxWidth: 200, in: self.view, from: contactErrorImage.frame)
                popTip.bubbleColor = .black
                popTip.shouldDismissOnTap = true
            }
        }
        else if textField == self.streetTextField {
            if streetErrorImage.alpha == 1 {
                let from = CGRect(x: streetErrorImage.frame.origin.x,
                                  y: streetErrorImage.frame.origin.y + secondView.frame.origin.y,
                                  width: streetErrorImage.frame.width,
                                  height: streetErrorImage.frame.height)
                popTip.show(text: "This field cannot be blank", direction: .down, maxWidth: 200, in: self.view, from: from)
                popTip.bubbleColor = .black
                popTip.shouldDismissOnTap = true
            }
        }
        else if textField == self.postalCodeTextField {
            if postalErrorImage.alpha == 1 {
                let from = CGRect(x: postalErrorImage.frame.origin.x,
                                  y: postalErrorImage.frame.origin.y + secondView.frame.origin.y,
                                  width: postalErrorImage.frame.width,
                                  height: postalErrorImage.frame.height)
                popTip.show(text: "This field cannot be blank", direction: .down, maxWidth: 200, in: self.view, from: from)
                popTip.bubbleColor = .black
                popTip.shouldDismissOnTap = true
            }
        }
    }
    
    @IBAction func addAddressButtonTap(_ sender: UIButton) {
        var check = false
        if (nameTextField.text?.isEmpty)! {
            nameErrorImage.alpha = 1
            check = true
        }
        if (contactNumberTextField.text?.isEmpty)! {
            contactErrorImage.alpha = 1
            check = true
        }
        if (streetTextField.text?.isEmpty)! {
            streetErrorImage.alpha = 1
            check = true
        }
        if (postalCodeTextField.text?.isEmpty)! {
            postalErrorImage.alpha = 1
            check = true
        }
        if check == true {
            return
        }
        
//        let header = NSMutableDictionary()
//        header.setValue("application/json", forKey: "Content-Type")
        let params = NSMutableDictionary()
        params.setValue(streetTextField.text ?? "", forKey: TAPConstants.APIParams.streetName)
        params.setValue(floorTextField.text ?? "", forKey: TAPConstants.APIParams.floor)
        params.setValue(unitTextField.text ?? "", forKey: TAPConstants.APIParams.unitNumber)
        params.setValue(postalCodeTextField.text ?? "", forKey: TAPConstants.APIParams.postalCode)
        params.setValue(nameTextField.text ?? "", forKey: TAPConstants.APIParams.alias)
        params.setValue(contactNumberTextField.text ?? "", forKey: TAPConstants.APIParams.contact)
        
        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendPOSTRequest(path: API_PATH(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/address"), params: params) { (check, value) in
            TAPGlobal.shared.dismissLoading()
            if check {
                let address = TAPProfileAddressModel()
                address.streetName = self.streetTextField.text ?? ""
                address.floor = self.floorTextField.text ?? ""
                address.unitNumber = self.unitTextField.text ?? ""
                address.postalCode = self.postalCodeTextField.text ?? ""
                address.alias = self.nameTextField.text ?? ""
                address.contact = self.contactNumberTextField.text ?? ""
                address.id = value
                self.delegate?.addAddress(address: address)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
