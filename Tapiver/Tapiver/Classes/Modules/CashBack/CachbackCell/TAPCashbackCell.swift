//
//  TAPCashbackCell.swift
//  Tapiver
//
//  Created by Hung vu on 12/24/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPCashbackCell: UITableViewCell {

    @IBOutlet weak var lbOrder: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbCashBack: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbCostCashback: UILabel!
    @IBOutlet weak var lbCostTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func setData(cashback: TAPCashbackEntity) {
        self.lbOrder.text = "\(cashback.orderId ?? 0)"
        self.lbTime.text = String.stringFromTimeInterval(cashback.orderDate ?? 0)
        self.lbStatus.text = cashback.status
        self.lbCostCashback.text  = "\(cashback.cashbackPercentage ?? 0)%"
        self.lbCostTotal.text = "SGD \(cashback.cashbackAmount ?? 0.00)"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
