//
//  TAPHistoryViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPHistoryViewController: TAPBaseViewController {
    @IBOutlet weak var contentTableView: UITableView!
    var orderList: [TAPOrderModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        orderList = [TAPOrderModel(), TAPOrderModel(), TAPOrderModel()]
        
    }
    
    private func setupView() {
        contentTableView.register(UINib.init(nibName: "TAPHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPHistoryTableViewCell")
        contentTableView.register(UINib.init(nibName: "TAPHistoryOrderInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPHistoryOrderInformationTableViewCell")
        contentTableView.register(UINib.init(nibName: "TAPHistoryHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "TAPHistoryHeaderView")
    }

}

extension TAPHistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numOfRows = 2
        if indexPath.row == numOfRows - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TAPHistoryOrderInformationTableViewCell", for: indexPath) as! TAPHistoryOrderInformationTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TAPHistoryTableViewCell", for: indexPath) as! TAPHistoryTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TAPHistoryHeaderView") as? TAPHistoryHeaderView// ?? TAPHistoryHeaderView(reuseIdentifier: "TAPHistoryHeaderView")
        header?.setCollapsed(orderList[section].isCollapsed)
        return header
    }
}

extension TAPHistoryViewController: UITableViewDelegate {
    
}

extension TAPHistoryViewController: TAPHistoryHeaderViewDelegate {
    func toggleSection(_ header: TAPHistoryHeaderView, section: Int) {
        let collapsed = !orderList[section].isCollapsed
        
        // Toggle collapse
        orderList[section].isCollapsed = collapsed
        header.setCollapsed(collapsed)
    }
}
