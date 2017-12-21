//
//  TAPHistoryHeaderView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

protocol TAPHistoryHeaderViewDelegate: class {
    func toggleSection(_ header: TAPHistoryHeaderView, section: Int)
}

class TAPHistoryHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var arrowButton: UIButton!
    
    weak var delegate: TAPHistoryHeaderViewDelegate?
    var section: Int = 0

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //
        // Call tapHeader when tapping on this header
        //
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeader(_:))))
        arrowButton.rotate(.pi)
        self.backgroundColor = UIColor.white
        arrowButton.isUserInteractionEnabled = false
        statusButton.isUserInteractionEnabled = false
    }
    
    func fillData(order: TAPOrderModel?) {
        guard let orderData = order else {
            return
        }
        orderIdLabel.text = "Order #" + (orderData.id ?? "")
        timeLabel.text = String.stringFromTimeInterval(orderData.orderDate ?? 0)
        statusButton.setTitle(orderData.orderStatus ?? "", for: .normal)
    }
    
    //
    // Trigger toggle section when tapping on the header
    //
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? TAPHistoryHeaderView else {
            return
        }
        
        delegate?.toggleSection(self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        //
        // Animate the arrow rotation (see Extensions.swf)
        //
        arrowButton.rotate(collapsed ? .pi : 0.0)
    }

}
