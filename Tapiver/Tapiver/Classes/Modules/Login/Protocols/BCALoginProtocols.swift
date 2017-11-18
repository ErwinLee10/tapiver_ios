//
//  TAPLoginProtocol.swift
//  Tapiver
//
//  Created by HungHN on 11/13/17.
//  Copyright © 2017 HungHoang. All rights reserved.
//

protocol TAPLoginViewProtocol: class {
    func loginCompleted()
}

protocol BCALoginPresenterProtocol: class {
    var loginModel: TAPLoginModel? { set get }
    func attachView(view: TAPLoginViewProtocol)
    func loginToServer()
}
