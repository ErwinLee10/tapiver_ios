//
//  TAPAddressMethodController.swift
//  Tapiver
//
//  Created by Hung vu on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPAddressMethodController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var isLoadedApi: Bool! = false
    var listData: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIb()
        initData()
    }
    func initData() {
        if isLoadedApi {
            callApi()
        }
    }
    func initIb() {
        self.tableView.register(UINib.init(nibName: "TAPHeaderAddTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPHeaderAddTableViewCell")
        self.tableView.register(UINib.init(nibName: "TAPAddessCell", bundle: nil), forCellReuseIdentifier: "TAPAddessCell")
        self.tableView.register(UINib.init(nibName: "TAPShippingMethodCell", bundle: nil), forCellReuseIdentifier: "TAPShippingMethodCell")
    }
    // MARK: call api
    func callApi() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension TAPAddressMethodController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
extension TAPAddressMethodController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counts:Int = listData?.count else {
            return 0
        }
        return counts
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPCategoryLever2Cell", for: indexPath) as? TAPCategoryLever2Cell else {
            return UITableViewCell()
        }
        guard let item = listData?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.typeLever = TAPCategoryLever2CellType.LandMark
        cell.setIB()
        cell.lbNameMenu2.text = item.name
        return cell
    }
}

