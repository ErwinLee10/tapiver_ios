//
//  TAPLoginPresenter.swift
//  Tapiver
//
//  Created by HungHN on 11/13/17.
//  Copyright © 2017 HungHoang. All rights reserved.
//

import UIKit

final class TAPLoginPresenter: BCALoginPresenterProtocol {
    
    fileprivate weak var viewPresenter: TAPLoginViewProtocol?
    var loginModel: TAPLoginModel?
    
    deinit {
        print("BCALoginPresenter has been deinit")
    }
    
    func attachView(view: TAPLoginViewProtocol) {
        self.viewPresenter = view
    }
    
    func loginToServer() {
        // get params from model
        
        // Call API - start
        self.viewPresenter?.loginCompleted()
        // Call API - end
    }
}
