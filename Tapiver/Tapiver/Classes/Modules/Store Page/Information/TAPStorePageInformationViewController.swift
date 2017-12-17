//
//  TAPStorePageInformationViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/17/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPStorePageInformationViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTableView: UITableView!
    var feedModel: TAPFeedModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    static func showStorePageInformation(data: Any?) {
        let vc = TAPStorePageInformationViewController(nibName: "TAPStorePageInformationViewController", bundle: nil)
        vc.showView()
    }

    private func setupView() {
        contentTableView.register(UINib.init(nibName: "TAPStorePageInfoDescriptionCell", bundle: nil), forCellReuseIdentifier: "TAPStorePageInfoDescriptionCell")
        contentTableView.register(UINib.init(nibName: "TAPStorePageInfoLocationCell", bundle: nil), forCellReuseIdentifier: "TAPStorePageInfoLocationCell")
        contentTableView.tableHeaderView = UIView(frame: CGRect.init(x: 0, y: 0, width: contentTableView.frame.width, height: 0.01))
        contentTableView.tableFooterView = UIView(frame: CGRect.init(x: 0, y: 0, width: contentTableView.frame.width, height: 0.01))
//        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    private func showView() {
//        self.modalPresentationStyle = .fullScreen
//        WINDOW?.rootViewController?.present(self, animated: true, completion: nil)
        WINDOW?.addSubview(self.view)
        self.view.makeContraintToFullWithParentView()
        WINDOW?.rootViewController?.addChildViewController(self)
        self.didMove(toParentViewController: WINDOW?.rootViewController)
    }
    
    private func hideView() {
//        self.dismiss(animated: false, completion: nil)
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    @IBAction func returnTouched(_ sender: Any) {
        hideView()
    }
    
    @IBAction func backgroundTouched(_ sender: Any) {
        hideView()
    }
}

extension TAPStorePageInformationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1 // TODO: Only has 1 address
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TAPStorePageInfoDescriptionCell", for: indexPath) as! TAPStorePageInfoDescriptionCell
            cell.setContent(description: "") // TODO: description
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TAPStorePageInfoLocationCell", for: indexPath) as! TAPStorePageInfoLocationCell
            cell.setContent(index: indexPath.row, address: feedModel?.sellerAddress)
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Desciption"
//        } else {
//            return "Location"
//        }
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 28))
        let headerTitleLb = UILabel()
        headerTitleLb.font = UIFont.boldSystemFont(ofSize: 17.0)
        headerTitleLb.textColor = UIColor.darkGray
        headerTitleLb.text = section == 0 ? "Desciption" : "Location"
        header.addSubview(headerTitleLb)
        headerTitleLb.makeContraintToFullWithParentView()
        header.makeContraintToFullWithParentView()
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}

extension TAPStorePageInformationViewController: UITableViewDelegate {
    
}

