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
        fatalError("init(coder:) has not been implemented")
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
//        arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
    }

}
