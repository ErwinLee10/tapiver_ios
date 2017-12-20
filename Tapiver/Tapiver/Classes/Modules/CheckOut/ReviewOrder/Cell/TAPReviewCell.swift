//
//  TAPReviewCell.swift
//  Tapiver
//
//  Created by Hung vu on 12/20/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPReviewCell: UITableViewCell {
    @IBOutlet weak var btViewLess: UIButton!
    @IBOutlet weak var lbJuntion: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btDetailClose: UIButton!
    @IBOutlet weak var lbStoreTotal: UILabel!
    @IBOutlet weak var lbCashback: UILabel!
    @IBOutlet weak var lbStore: UILabel!
    @IBOutlet weak var lbNameStore: UILabel!
    @IBOutlet weak var lbAddStore: UILabel!
    @IBOutlet weak var lbStyle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initIB()
        initData()
    }
    func initIB() {
        self.tableView.register(UINib.init(nibName: "TAPReviewCell", bundle: nil), forCellReuseIdentifier: "TAPReviewCell")
    }
    func initData() {
        
    }
    @IBAction func acDetail(_ sender: Any) {
        
    }
    
    @IBAction func acViewLess(_ sender: Any) {
        
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
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPSubShippingMethod", for: indexPath) as? TAPSubShippingMethod else {
//            return UITableViewCell()
//        }
//        cell.delegate = self
//        cell.index = indexPath
//        if tableView == self.tableStyle {
//            cell.obj = self.listData![indexPath.row]
//        }else {
//            let ob = TAPSubShippingEntity.init(title: "Store Pickup", cost: "Free", isSelect: false, cashBack: 5)
//            cell.obj = ob
//            
//        }
//        cell.setData()
//        return cell
        return UITableViewCell()
    }
    
}
