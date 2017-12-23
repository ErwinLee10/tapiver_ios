//
//  TAPReViewOrderController.swift
//  Tapiver
//
//  Created by Hung vu on 12/20/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

let HEIGHT_ADD_LESS: CGFloat = 1
let HEIGHT_ADD_MORE: CGFloat = 80.0
let STATIC_HEIGHT_ADD_MORE: CGFloat = 10.0 + 21.0 + 8.0 + 50.0 + 8.0 + 8.0 + 40.0 + 2.0

class TAPReViewOrderController: UIViewController {
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbDisCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    public var reviewObj: TAPReviewOrderEntity?
    @IBOutlet weak var headerView: TAPHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initIB()
        initData()
    }
    func initIB() {
        self.headerView.delegate = self
        self.tableView.register(UINib.init(nibName: "TAPReviewCell", bundle: nil), forCellReuseIdentifier: "TAPReviewCell")
        self.tableView.register(UINib.init(nibName: "TAPSubShippingMethod", bundle: nil), forCellReuseIdentifier: "TAPSubShippingMethod")
        self.lbTotal.text = "S$ \(reviewObj?.cardList?.finalTotalAmount ?? 0)"
        if let dis = reviewObj?.cardList?.originalTotalAmount  {
            if let bis = reviewObj?.cardList?.finalTotalAmount {
                if bis != dis {
                    self.lbDisCount.isHidden = false
                    self.lbDisCount.text = "Discount: S&\(bis - dis)"
                }
                
            }
        }
    }
    func initData() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
extension TAPReViewOrderController: TAPHeaderViewDelegate {
    func headerViewDidTouchBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension TAPReViewOrderController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cardItems = self.reviewObj?.cardList?.cartItemsPerSeller else {
            return 0
            
        }
        return cardItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = STATIC_HEIGHT_ADD_MORE
        guard let cardItems = self.reviewObj?.cardList?.cartItemsPerSeller else {
            return height
            
        }
        let item = cardItems[indexPath.row]
        
        if !item.isViewLess {
            height +=  HEIGHT_ADD_LESS
        }else {
            height +=  HEIGHT_ADD_MORE
        }
        
        if !item.isViewDetail {
            height +=  HEIGHT_ADD_LESS
        }else {
            guard let cardItem = self.reviewObj?.cardList?.cartItemsPerSeller[indexPath.row] else {
                return height
            }
            height += CGFloat(cardItem.productVariations.count) * 80.0
            
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPReviewCell") as? TAPReviewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        guard let cardItems = self.reviewObj?.cardList?.cartItemsPerSeller else {
            return UITableViewCell()
            
        }
        cell.indexPath = indexPath
        cell.cartItem = cardItems[indexPath.row]
        cell.address = self.reviewObj?.address
        cell.setData()
        return cell
    }
}
extension TAPReViewOrderController: UITableViewDelegate {
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
extension TAPReViewOrderController: TAPReviewCellDelegate {
    func tapSelectViewMore(isViewAdd: Bool, isViewDetail: Bool, isSelectViewAdd: Bool) {
        self.tableView.reloadData()
    }
}
