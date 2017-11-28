//
//  TAPIntroAppViewController.swift
//  Tapiver
//
//  Created by HungHN on 11/28/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import UIKit

class TAPIntroAppViewController: UIViewController {

    @IBOutlet weak var letGoBtn: UIButton!
    @IBOutlet private weak var pageView: UIView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    var currentIdex: Int = 0
    var pageViewController: UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViewController()
    }
    
    // MARK: Private methods
    private func setupViewController() {
        self.configPageViewController()
    }
    
    private func configPageViewController() {
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        guard let pageViewController = self.pageViewController else {
            return
        }
        
        self.pageViewController?.dataSource = self
        self.pageViewController?.delegate = self
        self.pageViewController?.view.backgroundColor = UIColor.clear
        self.pageViewController?.willMove(toParentViewController: self)
        self.addChildViewController(pageViewController)
        self.pageView.addSubview(pageViewController.view)
        self.pageViewController?.view.makeContraintToFullWithParentView()
        self.pageViewController?.didMove(toParentViewController: self)
        
        if let viewcontroller = self.getPageItem(with: 0) {
            self.pageViewController?.setViewControllers([viewcontroller], direction: .forward, animated: false, completion: nil)
        }
    }
    
    @IBAction func actionLetGo(_ sender: UIButton) {
        
        TAPMainFrame.showLoginPageMain()
    }
    
}
extension TAPIntroAppViewController {
    
    fileprivate func getPageItem(with index: Int) -> TAPIntroPageViewController? {
        var realIndex = index
        if(index < 0) {
            realIndex = 3
        }
        if(index > 3) {
            realIndex = 0
        }
        
        return self.makeViewController(index:realIndex)
    }
    
    fileprivate func makeViewController(index: Int) -> TAPIntroPageViewController? {
        let introductionVC = TAPIntroPageViewController(nibName: "TAPIntroPageViewController", bundle: nil)
        introductionVC.gIndex = index
        return introductionVC
    }
}

extension TAPIntroAppViewController: UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard viewController is TAPIntroPageViewController else {
            return nil
        }
        
        return self.getPageItem(with: ((viewController as? TAPIntroPageViewController)?.gIndex)! + 1)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard viewController is TAPIntroPageViewController else {
            return nil
        }
        
        return self.getPageItem(with: ((viewController as? TAPIntroPageViewController)?.gIndex)! - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
            let viewController = pageViewController.viewControllers?.first as? TAPIntroPageViewController else {
                return
        }
        
        let index = viewController.gIndex
        self.pageControl.currentPage = index
        self.currentIdex = index
        
        if index == 3 {
            letGoBtn.isHidden = false
        }
    }
}


extension UIView {
    class func instance(nibName name: String) -> UIView {
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func makeContraintToFullWithParentView() {
        
        guard let parrentView = self.superview else {
            return
        }
        
        let dict = ["view":self]
        self.translatesAutoresizingMaskIntoConstraints = false
        parrentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        parrentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
    }
    
}

