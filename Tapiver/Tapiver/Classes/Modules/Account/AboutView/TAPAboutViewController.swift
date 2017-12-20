//
//  TAPAboutViewController.swift
//  Tapiver
//
//  Created by admin on 12/19/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation

class TAPAboutViewController: UIViewController {
    @IBOutlet weak var version: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        self.title = "About"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.version.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
