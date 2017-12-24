//
//  TAPStorePageViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/14/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class TAPStorePageViewController: TAPBaseViewController {

    @IBOutlet var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var headerBgView: UIImageView!
    
    var productList: [TAPProductModel] = []
    var feedModel: TAPFeedModel?
    var storePageHeaderView: TAPStorePageHeaderView?
    
    static let cellIdentifier = "TAPMallPageDealsCell"
    let leftRightPadding = 15.0
    let cellPadding = 10.0
    let cellHeightWidhtRatio = 1.3
    let expandHeaderHeight: CGFloat = 90.0
    let collapseHeaderHeight: CGFloat = 44.0
    let animationDuration = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let feedModel = self.feedModel {
            storePageHeaderView?.fillData(entity: feedModel)
        }
        getData()
    }
    
    // MARK: Private methods
    private func setupView() {
        storePageHeaderView = headerView as? TAPStorePageHeaderView
        storePageHeaderView?.delegate = self
        if feedModel != nil {
            storePageHeaderView?.fillData(entity: feedModel!)
        }
//        headerViewHeight.constant = expandHeaderHeight
        
        headerBgView.sd_setImage(with: URL.init(string: feedModel?.sellerCoverPicture ?? ""), placeholderImage: nil, options: SDWebImageOptions.retryFailed, completed: nil)
        
        contentCollectionView.register(UINib.init(nibName: "TAPMallPageDealsCell", bundle: nil), forCellWithReuseIdentifier: TAPMallPageDealViewController.cellIdentifier)
        emptyLabel.isHidden = true
    }
    
    private func getData() {
        var params: [String: Any] = [:]
        params[TAPConstants.APIParams.sellerId] = feedModel?.sellerId
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
                //hahalalamummy
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

// MARK: UICollectionViewDataSource
extension TAPStorePageViewController: UICollectionViewDataSource {
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
extension TAPStorePageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openProductPage(product: productList[indexPath.row], feedModel: feedModel)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension TAPStorePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (Double(SCREEN_WIDTH) - leftRightPadding * 2 - cellPadding) / 2
        let cellHeight = cellWidth * cellHeightWidhtRatio
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: TAPHeaderViewDelegate
extension TAPStorePageViewController: TAPStorePageHeaderViewDelegate {
    func headerViewDidTouchBack() {
        
    }
    
    func headerViewDidTouchSearch() {
        
    }
    
    func headerViewDidTouchCart() {
        
    }
    
    func headerViewDidTouchMenu() {
        showRightMenu()
    }
    
    func headerViewDidTouchInfo() {
        TAPStorePageInformationViewController.showStorePageInformation(data: nil)
    }
    
    func headerViewDidTouchFollow() {
        
    }
}
