//
//  TAPDropdownBoxView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

protocol TAPDropdownBoxViewDelegate: class {
    func dropdownBox(_ dropdownBox: TAPDropdownBoxView, selectedValue: String?)
}

class TAPDropdownBoxView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var valueList: [String] = []
    weak var delegate: TAPDropdownBoxViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let views = Bundle.main.loadNibNamed("TAPDropdownBoxView", owner: self, options: nil)
        let mainView = views?[0] as! UIView
        self.addSubview(mainView)
        
        mainView.makeContraintToFullWithParentView()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.masksToBounds = true
        selectButton.rotate(.pi)
    }
    
    func setSelectedValue(_ value: String) {
        titleLabel.text = value
    }
    
    @IBAction func dropdownTouched(_ sender: Any) {
        showDropdownList()
    }
    
    @IBAction func selectBtnTouched(_ sender: Any) {
        showDropdownList()
    }
    
    private func showDropdownList() {
        if valueList.count == 0 {
            return
        }
        
        let dropdownList = TAPDropdownListViewController.dropdownViewController(dataList: valueList) { [weak self] (index) in
            if let strongSelf = self {
                if index < strongSelf.valueList.count {
                    strongSelf.titleLabel.text = strongSelf.valueList[index]
                    strongSelf.delegate?.dropdownBox(strongSelf, selectedValue: strongSelf.valueList[index])
                }
            }
        }
        
        dropdownList.modalPresentationStyle = .popover
        dropdownList.popoverPresentationController?.delegate = self
        
        dropdownList.preferredContentSize = CGSize(width: 200, height: 250)
        dropdownList.popoverPresentationController?.sourceView = selectButton
        
        //        dropdownList.popoverPresentationController?.sourceRect = CGRect(x: menuBtnFrame.width/2, y: menuBtnFrame.height, width: 1, height: 5)
        WINDOW?.rootViewController?.present(dropdownList, animated: true, completion: nil)
    }
    
}

extension TAPDropdownBoxView: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
