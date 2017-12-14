//
//  TAPBaseHeaderView.swift
//  Tapiver
//
//  Created by Le Duc Canh on 12/14/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

protocol TAPBaseHeaderViewDelegate: class {
    func headerViewDidTouchBack()
    func headerViewDidTouchSearch()
    func headerViewDidTouchCart()
    func headerViewDidTouchMenu()
}

extension TAPBaseHeaderViewDelegate {
    func headerViewDidTouchBack() {}
}

class TAPBaseHeaderView: UIView {

}
