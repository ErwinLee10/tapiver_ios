//
//  TAPShippingMethodCell.swift
//  Tapiver
//
//  Created by Hung vu on 12/18/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit
@objc protocol TAPShippingMethodCellDelegate: class {
    @objc func acSelectShippingMethodAt(index: IndexPath, obj: TAPShippingModel, withCard: TAPCartItemModel)
}
class TAPShippingMethodCell: UITableViewCell {
    @IBOutlet weak var tableStyle: UITableView!
    var checkOut: TAPChecOutEntity?
    public weak var delegate: TAPShippingMethodCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initIB()
    }
    private func initIB() {
        self.tableStyle.register(UINib.init(nibName: "TAPSubShippingMethod", bundle: nil), forCellReuseIdentifier: "TAPSubShippingMethod")
        self.tableStyle.delegate = self
        self.tableStyle.dataSource = self
    }
    public func initData() {
        self.tableStyle.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension TAPShippingMethodCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPSubShippingMethod") as? TAPSubShippingMethod else {
            return nil
        }
        guard let items = self.checkOut?.listShipping[section]  else {
            return nil
        }
        cell.viewHeader.isHidden = false
        cell.lbHeader.text = items.sellerName
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (cell.responds(to: #selector(getter: UIView.tintColor))) {
            let cornerRadius: CGFloat = 5
            cell.backgroundColor = UIColor.clear
            let layer: CAShapeLayer  = CAShapeLayer()
            let pathRef: CGMutablePath  = CGMutablePath()
            let bounds: CGRect  = cell.bounds.insetBy(dx: 0, dy: 0)
            var addLine: Bool  = false
            if (indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1) {
                pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
            } else if (indexPath.row == 0) {
                pathRef.move(to: CGPoint(x:bounds.minX,y:bounds.maxY))
                pathRef.addArc(tangent1End: CGPoint(x:bounds.minX,y:bounds.minY), tangent2End: CGPoint(x:bounds.midX,y:bounds.minY), radius: cornerRadius)
                
                pathRef.addArc(tangent1End: CGPoint(x:bounds.maxX,y:bounds.minY), tangent2End: CGPoint(x:bounds.maxX,y:bounds.midY), radius: cornerRadius)
                pathRef.addLine(to: CGPoint(x:bounds.maxX,y:bounds.maxY))
                addLine = true;
            } else if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1) {
                
                pathRef.move(to: CGPoint(x:bounds.minX,y:bounds.minY))
                pathRef.addArc(tangent1End: CGPoint(x:bounds.minX,y:bounds.maxY), tangent2End: CGPoint(x:bounds.midX,y:bounds.maxY), radius: cornerRadius)
                
                pathRef.addArc(tangent1End: CGPoint(x:bounds.maxX,y:bounds.maxY), tangent2End: CGPoint(x:bounds.maxX,y:bounds.midY), radius: cornerRadius)
                pathRef.addLine(to: CGPoint(x:bounds.maxX,y:bounds.minY))
                
            } else {
                pathRef.addRect(bounds)
                addLine = true
            }
            layer.path = pathRef
            //CFRelease(pathRef)
            //set the border color
            layer.strokeColor = UIColor.lightGray.cgColor;
            //set the border width
            layer.lineWidth = 1
            layer.fillColor = UIColor(white: 1, alpha: 1.0).cgColor
            
            
            if (addLine == true) {
                let lineLayer: CALayer = CALayer()
                let lineHeight: CGFloat  = (1 / UIScreen.main.scale)
                lineLayer.frame = CGRect(x:bounds.minX, y:bounds.size.height-lineHeight, width:bounds.size.width, height:lineHeight)
                lineLayer.backgroundColor = tableView.separatorColor!.cgColor
                layer.addSublayer(lineLayer)
            }
            
            let testView: UIView = UIView(frame:bounds)
            testView.layer.insertSublayer(layer, at: 0)
            testView.backgroundColor = UIColor.clear
            cell.backgroundView = testView
        }
        
    }
    
}
extension TAPShippingMethodCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sec = self.checkOut?.listShipping.count else {
            return 0
        }
        return sec
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = self.checkOut?.listShipping[section]  else {
            return 0
        }
        return items.shippingOptions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TAPSubShippingMethod", for: indexPath) as? TAPSubShippingMethod else {
            return UITableViewCell()
        }
        guard let items = self.checkOut?.listShipping[indexPath.section]  else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.index = indexPath
        cell.obj = items.shippingOptions[indexPath.row]
        cell.setData()
        return cell
    }
}
extension TAPShippingMethodCell: TAPSubShippingMethodDelegate {
    func selectAtIndex(index: IndexPath, obj: TAPShippingModel, isSelect: Bool) {
        let cartList = self.checkOut!.listShipping[index.section]
        for item in cartList.shippingOptions {
            if  item.isEqual(obj) {
                item.isSelect = true
            }else {
                item.isSelect = false
            }
        }
        self.tableStyle.reloadData()
        if self.delegate != nil {
            self.delegate?.acSelectShippingMethodAt(index: index, obj: obj, withCard:cartList)
        }
    }
}
