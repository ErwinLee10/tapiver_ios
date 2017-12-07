//
//  TAPFeedViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/29/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPFeedViewController: UIViewController  {

    @IBOutlet weak var collectionNew: UICollectionView!
    @IBOutlet weak var collectionHot: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionHot.register(UINib.init(nibName: "TAPFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TAPFeedCollectionViewCell")
        collectionNew.register(UINib.init(nibName: "TAPFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TAPFeedCollectionViewCell")
    }

}

extension TAPFeedViewController: UICollectionViewDataSource {
    
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

extension TAPFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let width = height * 3 / 4
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

extension TAPFeedViewController: UICollectionViewDelegate {
    
}
