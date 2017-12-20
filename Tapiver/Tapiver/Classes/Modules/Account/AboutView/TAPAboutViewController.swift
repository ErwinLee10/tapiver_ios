//
//  TAPAboutViewController.swift
//  Tapiver
//
//  Created by admin on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation

class TAPAboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        self.title = "About"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}
