//
//  TAPDealsViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
//import SVProgressHUD

class TAPDealsViewController: TAPBaseViewController {
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    var productList: [TAPProductModel] = []
    
    var errorInternetView: TAPLostConnectErrorView?
    var errorGeneralView: TAPGeneralErrorView?
    
    static let cellIdentifier = "TAPMallPageDealsCell"
    let leftRightPadding = 15.0
    let cellPadding = 10.0
    let cellHeightWidhtRatio = 1.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makePullToRefresh(tableName: contentCollectionView)
        getData(typeLoad: Table.none)
    }
    
    @objc override public func refreshData() {
        getData(typeLoad: Table.refresh)
    }
    
    // MARK: Private methods
    private func setupView() {
        
        let mainPageHeaderView = headerView as? TAPMainPageHeaderView
        mainPageHeaderView?.delegate = self
        contentCollectionView.register(UINib.init(nibName: "TAPMallPageDealsCell", bundle: nil), forCellWithReuseIdentifier: TAPMallPageDealViewController.cellIdentifier)
        emptyLabel.isHidden = true
    }
    
    private func getData(typeLoad: Table) {
        var page: Int = 0
        if  typeLoad == Table.none || typeLoad == Table.refresh {
            
            self.isMoreData = true
        }
        if typeLoad == Table.loadmore {
            page = productList.count
        }
        var params: [String: Any] = [:]
        if TAPGlobal.shared.hasLogin(), let userID = TAPGlobal.shared.getLoginModel()?.userId {
            params[TAPConstants.APIParams.userId] = userID.numberValue?.intValue ?? 0
			params[TAPConstants.APIParams.hasDeal] = true
            params[TAPConstants.APIParams.page] = page
        }
        
        TAPGlobal.shared.showLoading()
        TAPWebservice.shareInstance.sendGETRequest(path: TAPConstants.APIPath.getProducts, params: params, responseObjectClass: TAPProductListModel()) { [weak self] (success, responseEntity) in
            if success, let productListModel = responseEntity as? TAPProductListModel {
                
                if  typeLoad == Table.loadmore  {
                    if productListModel.productList.count > 0 {
                        for item in productListModel.productList {
                            self?.productList.append(item)
                        }
                    } else {
                        self?.isMoreData = false
                    }
                }else {
                    self?.productList = productListModel.productList
                    self?.endRefresh()
                }
                self?.reloadData()
            }
            else {
                TAPWebservice.shareInstance.checkHaveInternet(response: { (check) in
                    if check {
                        //server error
                        guard let unwrappedSelf = self else { return }
                        unwrappedSelf.errorGeneralView = Bundle.main.loadNibNamed("TAPGeneralErrorView", owner: unwrappedSelf, options: nil)![0] as? TAPGeneralErrorView
                        unwrappedSelf.errorGeneralView?.frame = unwrappedSelf.contentCollectionView.frame
                        unwrappedSelf.view.addSubview(unwrappedSelf.errorGeneralView!)
                        unwrappedSelf.view.bringSubview(toFront: unwrappedSelf.errorGeneralView!)
                    }
                    else {
                        guard let unwrappedSelf = self else { return }
                        unwrappedSelf.errorInternetView = Bundle.main.loadNibNamed("TAPLostConnectErrorView", owner: unwrappedSelf, options: nil)![0] as? TAPLostConnectErrorView
                        unwrappedSelf.errorInternetView?.frame = unwrappedSelf.contentCollectionView.frame
                        unwrappedSelf.view.addSubview(unwrappedSelf.errorInternetView!)
                        unwrappedSelf.view.bringSubview(toFront: unwrappedSelf.errorInternetView!)
                    }
                })
            }
            TAPGlobal.shared.dismissLoading()
        }
    }
    private func reloadData() {
        if productList.count == 0 {
            emptyLabel.isHidden = false
            contentCollectionView.isHidden = true
        } else {
            emptyLabel.isHidden = true
            contentCollectionView.isHidden = false
            contentCollectionView.reloadData()
        }
    }
}

extension TAPDealsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TAPMallPageDealViewController.cellIdentifier, for: indexPath) as! TAPMallPageDealsCell
        let row = indexPath.row
        cell.fillData(product: productList[row])
        if indexPath.item == productList.count - 1 && self.isMoreData ==  true {
            getData(typeLoad: Table.loadmore)
        }
        return cell
    }
}

extension TAPDealsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(indexPath.row)")
        openProductPage(product: productList[indexPath.row], feedModel: nil)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension TAPDealsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (Double(SCREEN_WIDTH) - leftRightPadding * 2 - cellPadding) / 2
        let cellHeight = cellWidth * cellHeightWidhtRatio
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension TAPDealsViewController: TAPMainPageHeaderViewDelegate {
    func headerViewDidTouchLeftMenu() {
        
    }
    
    func headerViewDidTouchMenu() {
        showRightMenu()
    }
    
    func headerViewDidTouchCart() {
        
    }
    
    func headerViewDidTouchSearch() {
        
    }
}
