//
//  TAPLoginViewController.swift
//  Tapiever
//  Created by HungHN on 11/13/17.
//  Copyright © 2017 HungHoang. All rights reserved.
//

import UIKit

final class TAPLoginViewController: UIViewController {
    
    let presenter = TAPLoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupViewController()
    }
    
    // MARK: Public methods
    // MARK: Private methods
    
    private func setupViewController() {
        self.configPresenter()
        // TODO: Anythings
    }
    
    private func configPresenter() {
        self.presenter.attachView(view: self)
    }
    
    @IBAction private func loginClicked(sender: UIButton) {
        // Show loading - start
        // TODO: will call self.presenter.loginToServer() when doing login feature
    }
    
}

extension TAPLoginViewController: TAPLoginViewProtocol {
    func loginCompleted() {
        
        // TODO: anything when login completed
        // Hiden loading view
    }
}
