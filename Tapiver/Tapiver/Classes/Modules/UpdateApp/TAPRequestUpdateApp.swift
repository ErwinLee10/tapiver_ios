//
//  TAPRequestUpdateApp.swift
//  Tapiver
//
//  Created by admin on 12/24/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation

class TAPRequestUpdateApp: UIView {
    
    @IBOutlet weak var tapiverLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tapiverLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    @IBAction func updateButtonTap(_ sender: UIButton) {
        let identifier = Bundle.main.infoDictionary!["CFBundleIdentifier"] as? String
        if let url = URL(string: "itms-apps://itunes.apple.com/app/\(identifier ?? "id1024941703")"),
            UIApplication.shared.canOpenURL(url)
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
