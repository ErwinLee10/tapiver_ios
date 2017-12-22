//
//  TAPReViewOrderController.swift
//  Tapiver
//
//  Created by Hung vu on 12/20/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPReViewOrderController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    public var reviewObj: TAPReviewOrderEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIB()
        initData()
    }
    func initIB() {
        self.tableView.register(UINib.init(nibName: "TAPReviewCell", bundle: nil), forCellReuseIdentifier: "TAPReviewCell")
        self.tableView.register(UINib.init(nibName: "TAPHeaderAddTableViewCell", bundle: nil), forCellReuseIdentifier: "TAPHeaderAddTableViewCell")
        
    }
    func initData() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
extension TAPReViewOrderController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection0:[TAPChecOutEntity] = self.listData[section] as? [TAPChecOutEntity] else {
            return 0
        }
        return listSection0.count
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reCell = UITableViewCell()
        
        return reCell
    }
}
extension TAPReViewOrderController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            layer.strokeColor = UIColor.clear.cgColor;
            //set the border width
            layer.lineWidth = 1
            layer.fillColor = UIColor.white.cgColor
            
            
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
