//
//  TAPReviewCell.swift
//  Tapiver
//
//  Created by Hung vu on 12/20/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
@objc protocol TAPReviewCellDelegate: class {
    @objc func tapSelectViewMore(isViewAdd: Bool, isViewDetail: Bool, isSelectViewAdd: Bool)
}

class TAPReviewCell: UITableViewCell {
    @IBOutlet weak var btViewLess: UIButton!
    @IBOutlet weak var lbJuntion: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btDetailClose: UIButton!
    @IBOutlet weak var lbCostStoreTotal: UILabel!
    @IBOutlet weak var lbCostShipping: UILabel!
    @IBOutlet weak var lbNameStore: UILabel!
    @IBOutlet weak var lbAddStore: UILabel!
    @IBOutlet weak var lbNameAdd: UILabel!
    @IBOutlet weak var heightTableview: NSLayoutConstraint!
    
    @IBOutlet weak var lbTitleShipping: UILabel!
    public var indexPath: IndexPath?
    public var cartItem: TAPCartItemModel?
    public var address: TAPAddressModel?
    public weak var delegate: TAPReviewCellDelegate?
    public var isViewLess: Bool  = false
    public var isViewDetail: Bool  = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initIB()
    }
    private func initIB() {
        self.tableView.register(UINib.init(nibName: "TAPCartTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPCartTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    private func initData() {
        
    }
    public func setData() {
        self.lbNameStore.text = cartItem?.sellerName
        self.lbJuntion.text = cartItem?.sellerAddress?.streetName
        self.lbAddStore.text = self.createContetn(obj: address!)
        let paser = self.paserObj()
        self.lbNameAdd.text = paser.address
        self.lbCostStoreTotal.text = paser.storeTotal
        self.lbTitleShipping.text = paser.titleShippng
        self.lbCostShipping.text = paser.costShiping
        self.btViewLess.isSelected = self.cartItem!.isViewLess
        self.btDetailClose.isSelected = self.cartItem!.isViewDetail
        if !self.cartItem!.isViewDetail {
            self.heightTableview.constant = 1.0
        }else {
            self.heightTableview.constant = CGFloat(cartItem!.productVariations.count) * 80.0
        }
        self.tableView.updateConstraints()
        self.tableView.reloadData()
    }
    private func paserObj() -> (address: String, storeTotal: String, titleShippng: String, costShiping: String ) {
        var add: String = ""
        let total: String = NSNumber(value: cartItem!.totalPrice!).moneyString()
        var titleshipping: String = ""
        var costShiping: String = ""
        for item  in self.cartItem!.shippingOptions {
            if item.isSelect == true {
                if item.provider == "Store" && item.type == "Pickup" && item.price == 0.0 {
                    add = "Store"
                    titleshipping = "Cash back"
                    costShiping = NSNumber(value: (item.additionalInfor?.cashbackPercentage)!).moneyString()
                }else {
                    titleshipping = item.type!
                    add = address?.contact ?? ""
                    costShiping = "S$ \(item.price ?? 0.00)"
                }
                break
            }
        }
        
        return (add,total,titleshipping,costShiping)
    }
    private func createContetn(obj: TAPAddressModel) -> String? {
        var content: String = ""
        if let street = obj.streetName {
            content.append("\(street)")
        }
        if let floor = obj.floor {
            var str = ""
            if let unitNumber = obj.unitNumber {
                str = ("-\(unitNumber)")
            }
            content.append("\n#\(floor)" + str)
        }else {
            if let unitNumber = obj.unitNumber {
                content.append("\n-\(unitNumber)")
            }
        }
        
        if let postalCode = obj.postalCode {
            content.append("\n\(postalCode)")
        }
        
        return content
    }
    
    @IBAction func acDetail(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.cartItem!.isViewDetail = sender.isSelected
        
        if delegate != nil {
            delegate?.tapSelectViewMore(isViewAdd: !sender.isSelected, isViewDetail: btViewLess.isSelected, isSelectViewAdd: false)
        }
        self.tableView.reloadData()
    }
    
    @IBAction func acViewLess(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.cartItem!.isViewLess  = sender.isSelected
        if delegate != nil {
            delegate?.tapSelectViewMore(isViewAdd: !sender.isSelected, isViewDetail: btDetailClose.isSelected, isSelectViewAdd: true)
        }
        self.tableView.reloadData()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension TAPReviewCell: UITableViewDelegate {
    
}
extension TAPReviewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counts = self.cartItem?.productVariations.count else {
            return 0
        }
        if !self.cartItem!.isViewDetail {
            return 0
        }
        return counts
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let counts = self.cartItem?.productVariations.count else {
            return 0.0
        }
        return  80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPCartTableViewCell", for: indexPath) as? TAPCartTableViewCell else {
            return UITableViewCell()
        }
        guard let item = self.cartItem?.productVariations[indexPath.row] else {
            return UITableViewCell()
        }
        cell.isReviewOrder = true
        cell.fillData(data: item)
        return cell
    }
    
}
