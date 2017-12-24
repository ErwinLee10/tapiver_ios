//
//  TAPPayMentMethodView.swift
//  Tapiver
//
//  Created by Hung vu on 12/23/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPPayMentMethodView: UIViewController {
    @IBOutlet weak var headerView: TAPHeaderView!
    @IBOutlet weak var sView: UIView!
    @IBOutlet weak var tfCardNumber: UITextField!
    
    @IBOutlet weak var tfCsv: UITextField!
    @IBOutlet weak var tfExpDate: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initIB()
        
    }
    private func initIB() {
        self.headerView.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension TAPPayMentMethodView: TAPHeaderViewDelegate {
    func headerViewDidTouchBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
