//
//  TAPReViewOrderController.swift
//  Tapiver
//
//  Created by Hung vu on 12/20/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPReViewOrderController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func initIB() {
        self.tableView.register(UINib.init(nibName: "TAPReviewCell", bundle: nil), forCellReuseIdentifier: "TAPReviewCell")
        self.tableView.register(UINib.init(nibName: "TAPHeaderAddTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPHeaderAddTableViewCell")
        
    }
    func initData() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
