//
//  TAPMenuViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/15/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPMenuViewController: UIViewController {

    @IBOutlet weak var contentTableView: UITableView!
    var selectionHandler:((Int) -> Void)?
    private var contentDic:[(String, String)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        makeData()
    }

    static func menuViewController(handler:@escaping ((Int) -> Void)) -> TAPMenuViewController {
        let vc = TAPMenuViewController(nibName: "TAPMenuViewController", bundle: nil)
        vc.selectionHandler = handler
        return vc
    }
    
    private func setupView() {
        contentTableView.register(UINib.init(nibName: "TAPMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPMenuTableViewCell")
        contentTableView.isScrollEnabled = false
    }
    
    private func makeData() {
        contentDic = [("menu_notif-icon","Notifications"),
                    ("menu_orders-icon","Orders"),
                    ("menu_cashback-icon","Cashback"),
                    ("menu_user-icon","Account"),
                    ("menu_feedback-icon","Feedback")
                    ]
    }
}

extension TAPMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TAPMenuTableViewCell", for: indexPath) as! TAPMenuTableViewCell
        let item = contentDic[indexPath.row]
        cell.setIcon(UIImage.init(named: item.0), title: item.1)
        return cell
    }
}

extension TAPMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        if selectionHandler != nil {
            selectionHandler!(indexPath.row)
        }
        
        self.dismiss(animated: true, completion: {
            switch indexPath.row {
            case 0: // Notifications
                break
            case 1: // Order
                break
            case 2: // Cashback
                break
            case 3: // Account
                if TAPGlobal.shared.hasLogin() {
                    // get top ViewController
                    let root = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                    let tabBar = root.topViewController as! TAPMainTabbarViewController
                    let naviTabBar = tabBar.viewControllers![tabBar.selectedIndex] as! UINavigationController
                    let topViewController = naviTabBar.topViewController
                    
                    // present TAPAccountViewController
                    let accountViewController: TAPAccountTableViewController = TAPAccountTableViewController(nibName: "TAPAccountTableViewController", bundle: nil)
                    let navi = UINavigationController(rootViewController: accountViewController)
                    navi.navigationBar.barTintColor = UIColor.init(netHex: 0x195B79)
                    topViewController?.present(navi, animated: true, completion: {
                        
                    })
                }
                else {
                    TAPMainFrame.showLoginPageMain()
                }
                break
            case 4: // Feedback
                break
            default:
                break
            }
        })
    }
}
