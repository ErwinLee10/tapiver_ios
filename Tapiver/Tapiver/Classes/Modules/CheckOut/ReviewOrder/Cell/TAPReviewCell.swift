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
        // Initialization code
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
