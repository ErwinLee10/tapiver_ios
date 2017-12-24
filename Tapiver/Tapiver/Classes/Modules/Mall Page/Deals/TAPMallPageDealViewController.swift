//
//  TAPMallPageDealViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/11/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD

class TAPMallPageDealViewController: TAPMallPageBaseViewController {
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
        getData()
    }
    
    
    
    // MARK: Private methods
    override func setupView() {
        super.setupView()
        let header  = headerView as? TAPHeaderView
        header?.delegate = self
        header?.setHeaderTitle(landmark?.name ?? "")
        
        contentCollectionView.register(UINib.init(nibName: "TAPMallPageDealsCell", bundle: nil), forCellWithReuseIdentifier: TAPMallPageDealViewController.cellIdentifier)
        emptyLabel.isHidden = true
    }
    
    private func getData() {
        var params: [String: Any] = [:]
        if let landmarkId = landmark?.id {
            params[TAPConstants.APIParams.landmarkId] = landmarkId
        }
        if TAPGlobal.shared.hasLogin(), let userID = TAPGlobal.shared.getLoginModel()?.userId {
            params[TAPConstants.APIParams.userId] = userID.numberValue?.intValue ?? 0
        }
        
        SVProgressHUD.show()
        TAPWebservice.shareInstance.sendGETRequest(path: TAPConstants.APIPath.getProducts, params: params, responseObjectClass: TAPProductListModel()) { [weak self] (success, responseEntity) in
            if success, let productListModel = responseEntity as? TAPProductListModel {
                self?.productList = productListModel.productList
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
            SVProgressHUD.dismiss()
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

// MARK: TAPHeaderViewDelegate
extension TAPMallPageDealViewController: TAPHeaderViewDelegate {
    func headerViewDidTouchBack() {
        
    }
    
    func headerViewDidTouchSearch() {
        
    }
    
    func headerViewDidTouchCart() {
        
    }
    
    func headerViewDidTouchMenu() {
        showRightMenu()
    }
}

// MARK: UICollectionViewDataSource
extension TAPMallPageDealViewController: UICollectionViewDataSource {
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
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension TAPMallPageDealViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        openProductPage(product: productList[row], feedModel: nil)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension TAPMallPageDealViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (Double(SCREEN_WIDTH) - leftRightPadding * 2 - cellPadding) / 2
        let cellHeight = cellWidth * cellHeightWidhtRatio
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
