//
//  TAPDropdownListViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPDropdownListViewController: UIViewController {
    @IBOutlet weak var contentTableView: UITableView!
    var selectionHandler:((Int) -> Void)?
    var contentData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownCell")
    }
    
    static func dropdownViewController(dataList:[String], handler:@escaping ((Int) -> Void)) -> TAPDropdownListViewController {
        let vc = TAPDropdownListViewController(nibName: "TAPDropdownListViewController", bundle: nil)
        vc.contentData = dataList
        vc.selectionHandler = handler
        return vc
    }

}

extension TAPDropdownListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.textLabel?.text = contentData[indexPath.row]
        return cell
    }
}

extension TAPDropdownListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        
        if selectionHandler != nil {
            selectionHandler!(indexPath.row)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.textLabel != nil {
            cell.indentationWidth = (cell.frame.width - cell.textLabel!.frame.width)/2
        }
    }
}
