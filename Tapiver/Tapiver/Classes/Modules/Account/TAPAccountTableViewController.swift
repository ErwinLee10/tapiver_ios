//
//  TAPAccountTableViewController.swift
//  Tapiver
//
//  Created by admin on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPAccountTableViewController: UIViewController, TAPEmailChangeViewDelegate, TAPAddNewAddressViewControllerDelegate, TAPAddressViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var scrollViewContainView: UIView!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var viewContainAddress: UIView!
    @IBOutlet weak var addressStackView: UIStackView!
    @IBOutlet weak var totalTextField: UILabel!
    @IBOutlet weak var cashbackView: UIView!
    @IBOutlet weak var userAgreement: UILabel!
    @IBOutlet weak var privacy: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var logout: UILabel!
    
    var profileData: TAPProfileModel!
    
    var addressViewHeight: CGFloat!
        
    override func viewDidLoad() {
        self.profileData = TAPGlobal.shared.getProfileModel()
        if (profileData == nil) {
            getData()
        }
        else {
            setupUI()
            getAddress(profileData: self.profileData)
        }
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        self.title = "Account"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(self.backButtonAction(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        nameTextField.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        setupEvent()
        
    }
    
    @objc func backButtonAction(sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        nameTextField.text = String(profileData.firstName! + " " + profileData.lastName!)
        emailTextField.text = profileData.email
        totalTextField.text = String(profileData.cashbacks ?? 0)
    }
    
    func setupAddressUI() {
        guard let addressList = profileData.address?.listProfileAddress else {
            return
        }
        if addressList.count > 0 {
//            for i in 0..<self.addressStackView.arrangedSubviews.count {
//                if i != 0 {
//                    self.addressStackView.removeArrangedSubview(self.addressStackView.arrangedSubviews[1])
//                }
//            }
            var addressViewList: [TAPAddressView] = []
            for address in addressList {
                let addressView: TAPAddressView = Bundle.main.loadNibNamed("TAPAddressView", owner: nil, options: nil)?.first as! TAPAddressView
                addressView.setData(name: address.alias!, contactNumber: address.contact!, street: address.streetName!, floor: address.floor!, unit: address.unitNumber!, postal: address.postalCode!)
                addressView.id = address.id
                addressView.delegate = self
                addressViewList.append(addressView)
            }
            
            var y: CGFloat = 50
            for i in 0..<addressViewList.count {
                addressViewList[i].heightAnchor.constraint(equalToConstant: 111.0).isActive = true
                addressViewList[i].widthAnchor.constraint(equalToConstant: self.addressStackView.frame.width).isActive = true

                self.addressStackView.addArrangedSubview(addressViewList[i])
                y += 111
            }
            
            y -= 111
            self.viewContainAddress.frame = CGRect(x: self.viewContainAddress.frame.origin.x, y: self.viewContainAddress.frame.origin.y, width: self.viewContainAddress.frame.width, height: y)
            
            y -= 50
            self.scrollView.layoutIfNeeded()
            self.scrollView.layoutSubviews()
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: 16+100+16+50+y+16+100+16+200+16 + (self.navigationController?.navigationBar.frame.height)! + 106)
            //16+100+16+50+y+16+100+16+200+16+44
        }
    }
    
    func setupEvent() {
        let tapGesture1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goEmail(_:)))
        emailView.addGestureRecognizer(tapGesture1)
        
        userAgreement.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(goUserAgreement(tapGestureRecognizer:)))
        userAgreement.addGestureRecognizer(tapGesture2)
        
        privacy.isUserInteractionEnabled = true
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(goPrivacy(tapGestureRecognizer:)))
        privacy.addGestureRecognizer(tapGesture3)
        
        about.isUserInteractionEnabled = true
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(goAbout(tapGestureRecognizer:)))
        about.addGestureRecognizer(tapGesture4)
        
        logout.isUserInteractionEnabled = true
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(goLogout(tapGestureRecognizer:)))
        logout.addGestureRecognizer(tapGesture5)
    }
    
    @objc func goEmail(_ gestureRecognizer: UITapGestureRecognizer) {
        let changEmailView = TAPEmailChangeView(nibName: "TAPEmailChangeView", bundle: nil)
        changEmailView.title = "Email"
        changEmailView.email = profileData.email
        changEmailView.delegate = self
        self.navigationController?.pushViewController(changEmailView, animated: true)
    }
    
    @objc func goUserAgreement(tapGestureRecognizer: UITapGestureRecognizer) {
        openURL(url: "https://www.tapiver.com/termsandconditions")
    }
    
    @objc func goPrivacy(tapGestureRecognizer: UITapGestureRecognizer) {
        openURL(url: "https://www.tapiver.com/privacy")
    }
    
    @objc func goAbout(tapGestureRecognizer: UITapGestureRecognizer) {
        let aboutView = TAPAboutViewController(nibName: "TAPAboutViewController", bundle: nil)
        self.navigationController?.pushViewController(aboutView, animated: true)
    }
    
    @objc func goLogout(tapGestureRecognizer: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "Are you sure you want to log out?", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { action in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { action in
            TAPWebservice.shareInstance.logout { (check) in
                if check {
                    self.navigationController?.dismiss(animated: true, completion: nil)
                }
            }
        }
        alertController.addAction(yesAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }

    @IBAction func manageAddressButtonTap(_ sender: UIButton) {
        let addAddressView = TAPAddNewAddressViewController(nibName: "TAPAddNewAddressViewController", bundle: nil)
        addAddressView.title = "Add New Address"
        addAddressView.delegate = self
        self.navigationController?.pushViewController(addAddressView, animated: true)
    }
    
    func getData() {
        let params: [String: Any] = [:]
        var apiPath: String
        if(TAPGlobal.shared.hasLogin()) {
            apiPath = "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/profile"
        } else {
            apiPath = TAPConstants.APIPath.overview
        }
        
        TAPWebservice.shareInstance.sendGETRequest(path: apiPath, params: params, responseObjectClass: TAPProfileModel()) { [weak self] (success, response) in
            if success, let profileData = response as? TAPProfileModel {
                //TAPGlobal.shared.saveProfileModel(model: profileData)
                self?.profileData = profileData
                self?.setupUI()
                self?.getAddress(profileData: profileData)
            }
        }
    }
    
    func getAddress(profileData: TAPProfileModel) {
        TAPWebservice.shareInstance.sendGETRequest(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/address", params: [:], responseObjectClass: TAPListProfileAddress()) { (success, response) in
            if success, let addressData = response as? TAPListProfileAddress {
                profileData.address = addressData
                TAPGlobal.shared.saveProfileModel(model: profileData)
                self.profileData = profileData
                self.setupAddressUI()
            }
        }
    }
    
    func openURL(url: String) {
        if #available(iOS 10, *) {
            let url = URL(string: url)
            UIApplication.shared.open(url!, options: [:], completionHandler: { (check) in
                
            })
        }
        else {
            let url = URL(fileURLWithPath: url)
            UIApplication.shared.openURL(url)
        }
    }
    
    func updateEmail(email: String) {
        self.profileData.email = email
        TAPGlobal.shared.saveProfileModel(model: profileData)
        setupUI()
    }
    
    func addAddress(address: TAPProfileAddressModel) {
        self.profileData.address?.listProfileAddress?.append(address)
        //setupAddressUI()
        let addressView: TAPAddressView = Bundle.main.loadNibNamed("TAPAddressView", owner: nil, options: nil)?.first as! TAPAddressView
        addressView.setData(name: address.alias!, contactNumber: address.contact!, street: address.streetName!, floor: address.floor!, unit: address.unitNumber!, postal: address.postalCode!)
        addressView.id = address.id
        addressView.heightAnchor.constraint(equalToConstant: 111.0).isActive = true
        addressView.widthAnchor.constraint(equalToConstant: self.addressStackView.frame.width).isActive = true
        self.addressStackView.addArrangedSubview(addressView)
        
        self.scrollView.layoutIfNeeded()
        self.scrollView.layoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.scrollView.contentSize.height + 111)
    }
    
    func deleteAddress(id: Int) {
        for (i,address) in (profileData.address?.listProfileAddress)!.enumerated().reversed() {
            if address.id == id {
                profileData.address?.listProfileAddress?.remove(at: i)
                self.addressStackView.arrangedSubviews[i+1].isHidden = true
                self.addressStackView.removeArrangedSubview(self.addressStackView.arrangedSubviews[i+1])
                self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.scrollView.contentSize.height - 111)
                break
            }
        }
    }
}
