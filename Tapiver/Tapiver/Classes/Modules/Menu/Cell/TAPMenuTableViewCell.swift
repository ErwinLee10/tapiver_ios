//
//  TAPMenuTableViewCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/15/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setIcon(_ icon: UIImage?, title: String?) {
        iconImgView.image = icon
        titleLabel.text = title
    }
    
}
