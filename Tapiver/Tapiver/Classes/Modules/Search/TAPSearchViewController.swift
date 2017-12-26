//
//  TAPSearchViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/23/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPSearchViewController: TAPBaseViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var storeTabButton: UIButton!
    @IBOutlet weak var productTabButton: UIButton!
    @IBOutlet weak var contentContainer: UIView!
    
    var productVC: TAPSearchProductViewController?
    var storeVC: TAPSearchStoreViewController?
    var isProductDisplaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        searchTextField.tintColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTextField.becomeFirstResponder()
    }

    @IBAction func backBtnTouched(_ sender: Any) {
        TAPMainFrame.getNavi().popViewController(animated: true)
    }
    
    @IBAction func productBtnTouched(_ sender: Any) {
        setTabSelected(isProduct: true)
        switchChildVC(isProduct: true)
        if let searchKey = searchTextField.text, searchKey.isEmpty == false {
            productVC?.search(with: searchKey)
        }
    }
    
    @IBAction func storeBtnTouched(_ sender: Any) {
        setTabSelected(isProduct: false)
        switchChildVC(isProduct: false)
        if let searchKey = searchTextField.text, searchKey.isEmpty == false {
            storeVC?.search(with: searchKey)
        }
    }
    
    private func setupView() {
        setTabSelected(isProduct: true)
        switchChildVC(isProduct: true)
    }
    
    private func setTabSelected(isProduct: Bool) {
        if isProduct {
            productTabButton.isSelected = true
            productTabButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            storeTabButton.isSelected = false
            storeTabButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        } else {
            productTabButton.isSelected = false
            productTabButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            storeTabButton.isSelected = true
            storeTabButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        }
    }
    
    private func switchChildVC(isProduct: Bool) {
        if isProductDisplaying == isProduct {
            return
        }
        isProductDisplaying = isProduct
        //searchTextField.text = ""
        
        if isProduct {
            if let vc = storeVC {
                removeChildVC(vc)
            }
            addProductChildVC()
        } else {
            if let vc = productVC {
                removeChildVC(vc)
            }
            addStoreChildVC()
        }
    }
    
    private func addProductChildVC() {
        productVC = TAPSearchProductViewController(nibName: "TAPSearchProductViewController", bundle: nil)
        addChildViewController(productVC!)
        contentContainer.addSubview(productVC!.view)
        productVC?.view.makeContraintToFullWithParentView()
        productVC?.didMove(toParentViewController: self)
    }
    
    private func addStoreChildVC() {
        storeVC = TAPSearchStoreViewController(nibName: "TAPSearchStoreViewController", bundle: nil)
        addChildViewController(storeVC!)
        contentContainer.addSubview(storeVC!.view)
        storeVC?.view.makeContraintToFullWithParentView()
        storeVC?.didMove(toParentViewController: self)
    }
    
    private func removeChildVC(_ vc: UIViewController) {
        vc.willMove(toParentViewController: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
}

extension TAPSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let searchKeyword = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return true
        }
        guard searchKeyword.isEmpty == false else {
            return true
            
        }
        if isProductDisplaying {
            productVC?.search(with: searchKeyword)
        } else {
            storeVC?.search(with: searchKeyword)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}
