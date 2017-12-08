//
//  TAPFeedTableViewCell.swift
//  Tapiver
//
//  Created by HungHN on 12/8/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPFeedTableViewCell: UITableViewCell {

     @IBOutlet weak var collectionHot: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionHot.delegate = self
        collectionHot.dataSource = self
        collectionHot.register(UINib.init(nibName: "TAPFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TAPFeedCollectionViewCell")

    }
    
}

extension TAPFeedTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TAPFeedCollectionViewCell", for: indexPath) as? TAPFeedCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension TAPFeedTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let width = height * 3 / 4
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

extension TAPFeedTableViewCell: UICollectionViewDelegate {
    
}
