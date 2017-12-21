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
        //
        // Call tapHeader when tapping on this header
        //
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeader(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
//        arrowButton.rotate(collapsed ? 0.0 : .pi)
    }

}
