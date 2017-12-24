//
//  TAPLoadingView.swift
//  Tapiver
//
//  Created by admin on 12/23/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
import FLAnimatedImage

class TAPLoadingView: UIView {
    
    @IBOutlet weak var gifView: FLAnimatedImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        if let path =  Bundle.main.path(forResource: "Tapiver GIF", ofType: "gif") {
            if let data = NSData(contentsOfFile: path) {
                let gif = FLAnimatedImage(animatedGIFData: data as Data!)
                gifView.animatedImage = gif
            }
        }
    }

}
