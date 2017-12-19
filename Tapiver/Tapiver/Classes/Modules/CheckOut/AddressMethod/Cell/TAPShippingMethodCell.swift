//
//  TAPShippingMethodCell.swift
//  Tapiver
//
//  Created by Hung vu on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
@objc protocol TAPShippingMethodCellDelegate: class {
    @objc func acSelectShippingMethodAt(index: IndexPath, obj:TAPSubShippingEntity)
}
class TAPShippingMethodCell: UITableViewCell {
    
    @IBOutlet weak var tableStyle: UITableView!
    var listData :[TAPSubShippingEntity]?
    public weak var delegate: TAPShippingMethodCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initIB()
        initData()
    }
    func initIB() {
        self.tableStyle.register(UINib.init(nibName: "TAPSubShippingMethod", bundle: nil), forCellReuseIdentifier: "TAPSubShippingMethod")
        self.tableStyle.delegate = self
        self.tableStyle.dataSource = self
    }
    func initData() {
        self.listData = TAPListSubShippingEntity().listData
        
    }
    public func setData() {
        self.tableStyle.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension TAPShippingMethodCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
extension TAPShippingMethodCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counts = self.listData?.count else {
            return 0
        }
        return counts
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPSubShippingMethod", for: indexPath) as? TAPSubShippingMethod else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.index = indexPath
        cell.obj = self.listData![indexPath.row]
        cell.setData()
        return cell
    }
}
extension TAPShippingMethodCell: TAPSubShippingMethodDelegate {
    func selectAtIndex(index: IndexPath, obj: TAPSubShippingEntity) {
        if self.delegate != nil {
            self.delegate?.acSelectShippingMethodAt(index: index, obj: obj)
        }
    }
}
