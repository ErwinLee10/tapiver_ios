//
//  TAPCategoryLever1Cell.swift
//  Tapiver
//
//  Created by HungVT on 12/14/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
@objc protocol TAPCategoryLever1CellDelegate: class {
    func tapMenu1At (index1: IndexPath, subIndex1: IndexPath)
    func objectWhenTap (object: TAPCategoryMenuEntity)
}

class TAPCategoryLever1Cell: UITableViewCell {
    @IBOutlet weak var lbNameSubMenu: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var listData: [TAPCategoryMenuEntity] = []
    weak var delegate: TAPCategoryLever1CellDelegate?
    public var indexLever1: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initIB()
    }
    func initIB() {
        self.tableView.register(UINib.init(nibName: "TAPCategoryLever2Cell", bundle: nil), forCellReuseIdentifier: "TAPCategoryLever2Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    public func reloadData(lists :[TAPCategoryMenuEntity]){
        listData = lists
        self.tableView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension TAPCategoryLever1Cell: UITableViewDelegate {
    
}

extension TAPCategoryLever1Cell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPCategoryLever2Cell", for: indexPath) as? TAPCategoryLever2Cell else {
            return UITableViewCell()
        }
        let item = listData[indexPath.row] 
        cell.lbNameMenu2.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tapMenu1At(index1: indexLever1!, subIndex1: indexPath)
        delegate?.objectWhenTap(object: listData[indexPath.row])
    }
    
}
