//
//  TAPStorePageInfoDescriptionCell.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/17/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPStorePageInfoDescriptionCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentLabel.text = "contentLabel contentLabel contentLabel contentLabel contentLabel contentLabel contentLabel contentLabel"
    }
    
    func setContent(description: String?) {
        contentLabel.text = description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
