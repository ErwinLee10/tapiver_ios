//
//  BCAExtention.swift
//
//  Created by Thuy Do Thanh on 11/13/17.
//  Copyright © 2017 Thuy Do Thanh. All rights reserved.
//

import Foundation
import UIKit
var refreshControl: UIRefreshControl?

extension UIViewController {
    // MARK : Pull Refresh - Start
    func makePullToRefresh(tableName: UIScrollView){
        refreshControl = UIRefreshControl()
        if #available(iOS 10.0, *) {
            tableName.refreshControl = refreshControl
        } else {
            tableName.addSubview(refreshControl!)
        }
        refreshControl?.addTarget(self, action: #selector(UIViewController.refreshData), for: .valueChanged)
    }
    @objc public func refreshData() {
        
    }
    func endRefresh(){
        if refreshControl!.isRefreshing {
            refreshControl!.endRefreshing()
        }
    }
    // MARK : Pull Refresh - End
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func setGradientBackground(startColor: UIColor, endColor: UIColor) {
        let colorTop =  startColor.cgColor
        let colorBottom = endColor.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func convertFrameToView(view: UIView) -> CGRect? {
        guard let superview = self.superview else {
            return nil
        }
        return superview.convert(view.frame, to: view)
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
    
}

extension UIImage {
    class func imageFromColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension String {
    
    var numberValue: NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        //        formatter.maximumFractionDigits = 0
        return formatter.number(from: self)
    }
    
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    func length() -> Int {
        return self.count
    }
    
    static func stringFromTimeInterval(_ interval: Double) -> String {
        let date = Date(timeIntervalSince1970: interval)
        return date.stringFromDate()
    }
}

extension NSDictionary {
    
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return "?"+parts.joined(separator: "&")
    }
}

extension NSNumber {
    func string(numberStyle: NumberFormatter.Style = .decimal, maximumFractionDigits: Int = 2) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = numberStyle
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.locale = Locale(identifier: "en_US")
        let outputString = formatter.string(from: self)
        return outputString
    }
    
    func moneyString() -> String {
        guard let result = string(numberStyle: .currency, maximumFractionDigits: 2) else {
            return ""
        }
        return "S\(result)"
    }
}

extension Date {
    
    func stringFromDate() -> String {
        let formater = DateFormatter()
        formater.dateStyle = DateFormatter.Style.long
        let result = formater.string(from: self)
        return result
    }
}



