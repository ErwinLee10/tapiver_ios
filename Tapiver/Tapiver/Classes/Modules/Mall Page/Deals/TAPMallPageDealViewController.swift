//
//  TAPMallPageDealViewController.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/11/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPMallPageDealViewController: TAPBaseViewController {
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet var mainHeaderHeight: NSLayoutConstraint!
    
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

    // MARK: Public methods
    
    // MARK: Private methods
    private func setupView() {
        headerView?.delegate = self
        headerView?.expandViewAnimation(true)
        mainHeaderHeight.constant = expandHeaderHeight
        
        contentCollectionView.register(UINib.init(nibName: "TAPMallPageDealsCell", bundle: nil), forCellWithReuseIdentifier: TAPMallPageDealViewController.cellIdentifier)
    }
}

// MARK: TAPHeaderViewDelegate
extension TAPMallPageDealViewController: TAPHeaderViewDelegate {
    func headerViewDidTouchBack() {
        TAPMainFrame.getNavi().popViewController(animated: true)
    }
    
    func headerViewDidTouchSearch() {
        
    }
    
    func headerViewDidTouchCard() {
        
    }
}

// MARK: UICollectionViewDataSource
extension TAPMallPageDealViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TAPMallPageDealViewController.cellIdentifier, for: indexPath) as! TAPMallPageDealsCell
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension TAPMallPageDealViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension TAPMallPageDealViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (Double(SCREEN_WIDTH) - leftRightPadding * 2 - cellPadding) / 2
        let cellHeight = cellWidth * cellHeightWidhtRatio
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension TAPMallPageDealViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerView = headerView else {
            return
        }
        
        let contentOffset = scrollView.contentOffset.y
        let baseContentOffset: CGFloat = 10.0
        
        if contentOffset > baseContentOffset {
            if headerView.isExpand {
                mainHeaderHeight.constant = collapseHeaderHeight
                UIView.animate(withDuration: animationDuration, animations: {
                    headerView.expandViewAnimation(false)
                    self.view.layoutIfNeeded()
                }) { (isComplete) in
                    
                }
            }
        } else if contentOffset < -baseContentOffset {
            if headerView.isExpand == false {
                mainHeaderHeight.constant = expandHeaderHeight
                UIView.animate(withDuration: animationDuration, animations: {
                    headerView.expandViewAnimation(true)
                    self.view.layoutIfNeeded()
                }) { (isComplete) in
                    
                }
            }
        }
    }
}
