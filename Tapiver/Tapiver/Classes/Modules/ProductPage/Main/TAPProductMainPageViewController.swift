//
//  TAPProductMainPageViewController.swift
//  Tapiver
//
//  Created by HungHN on 12/13/17.
//  Copyright © 2017 hunghoang. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import DropDown
import SVProgressHUD

class TAPProductMainPageViewController: UIViewController, TapProductShippingView2Delegate {

    // top bar
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    // main view
    @IBOutlet weak var imageContainView: UIView!
    @IBOutlet weak var imagePageView: iCarousel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var colorTableView: UITableView!
    @IBOutlet weak var colorTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleStackContainView: UIView!
    @IBOutlet weak var titleStackContainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleStack: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleStackBrandView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var titleStackDiscountView: UIView!
    @IBOutlet weak var beforeDiscountedPriceLabel: UILabel!
    @IBOutlet weak var discountedPercentageLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleStackOutOfStockView: UIView!
    @IBOutlet weak var outOfStockLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var shippingStackContainView: UIView!
    @IBOutlet weak var shippingStack: UIStackView!
    @IBOutlet weak var shippingViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyLocationLabel: UILabel!
    @IBOutlet weak var companyFollowerLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    //add to cart view
    @IBOutlet weak var addToCartView: UIView!
    @IBOutlet weak var addToCartViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var addToCartStackView: UIStackView!
    @IBOutlet weak var addToCartColorView: UIView!
    @IBOutlet weak var addToCartColorPickView: UIView!
    @IBOutlet weak var addToCartColorPreviewView: UIView!
    @IBOutlet weak var addToCartColorNameLabel: UILabel!
    
    @IBOutlet weak var addToCartSizeView: UIView!
    @IBOutlet weak var addToCartSizePickView: UIView!
    @IBOutlet weak var addToCartSizeLabel: UILabel!
    
    @IBOutlet weak var addToCartQuantityPickView: UIView!
    @IBOutlet weak var addToCartQuantityLabel: UILabel!
    
    //store pick up view
    @IBOutlet weak var storePickUpView: UIView!
    @IBOutlet weak var storePickupLabel: UILabel!
    @IBOutlet weak var storePickupCostLabel: UILabel!
    @IBOutlet weak var storePickupTimeLabel: UILabel!
    @IBOutlet weak var storePickupLocationTitleLabel: UILabel!
    @IBOutlet weak var storePickUpLocationLabel: UILabel!
    @IBOutlet weak var storePickUpOpenTimeLabel: UILabel!
    
    private var currentIdex: Int = 0
    private var items: [String]  = []
    private var listColor: [String] = []
    
    var id: String?
    var titleText: String?
    private var data: TAPProductDetailModel?
    
    let dropDownColor = DropDown()
    let dropDownSize = DropDown()
    let dropDownQuantity = DropDown()
    
    //add to cart
    var chooseColorName: String?
    var chooseSize: String?
    var chooseQuantity: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageView()
        
        self.titleLabel.text = titleText
        self.colorTableView.separatorStyle = .none
        addToCartView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        addToCartView.isHidden = true
        storePickUpView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        storePickupLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        storePickupCostLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        storePickupTimeLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        storePickupLocationTitleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        storePickUpView.isHidden = true
        
        colorTableView.register(UINib(nibName: "TAPProductColorViewCell", bundle: nil), forCellReuseIdentifier: "TAPProductColorViewCell")
        
        let colorPickTap = UITapGestureRecognizer(target: self, action: #selector(self.colorPickTap(_:)))
        addToCartColorPickView.addGestureRecognizer(colorPickTap)
        addToCartColorPickView.isUserInteractionEnabled = true
        
        let sizePickTap = UITapGestureRecognizer(target: self, action: #selector(self.sizePickTap(_:)))
        addToCartSizePickView.addGestureRecognizer(sizePickTap)
        self.addToCartSizePickView.isUserInteractionEnabled = true
        
        let quantityPickTap = UITapGestureRecognizer(target: self, action: #selector(self.quantityPickTap(_:)))
        addToCartQuantityPickView.addGestureRecognizer(quantityPickTap)
        self.addToCartQuantityPickView.isUserInteractionEnabled = true
        
        let addToCartTap = UITapGestureRecognizer(target: self, action: #selector(self.hideAddToCartView(_:)))
        addToCartView.addGestureRecognizer(addToCartTap)
        addToCartView.isUserInteractionEnabled = true
        
        let storePickUpTap = UITapGestureRecognizer(target: self, action: #selector(self.hideStorePickupView(_:)))
        storePickUpView.addGestureRecognizer(storePickUpTap)
        storePickUpView.isUserInteractionEnabled = true
        
        dropDownColor.dismissMode = .onTap
        dropDownSize.dismissMode = .onTap
        dropDownQuantity.dismissMode = .onTap
    }
    
    func setupPageView() {
        self.imagePageView.type = .linear
        self.imagePageView.isPagingEnabled = true
        self.imagePageView.delegate = self
        self.imagePageView.dataSource = self
    }
    
    func setData(id: String, title: String) {
        self.id = id
        self.titleText = title
        getData()
    }
    
    func getData() {
        TAPWebservice.shareInstance.sendGETRequest(path: "/api/v1/products/\(id ?? "0")/details", params: [TAPConstants.APIParams.userId: TAPGlobal.shared.getLoginModel()?.userId ?? ""],responseObjectClass: TAPProductDetailModel()) { (check, value) in
            if check {
                self.data = value as? TAPProductDetailModel
                self.setupUI()
            }
        }
    }
    
    func setupUI() {
        updateLikeUI()
        
        if checkIfHasManyColor() == false {
            colorTableView.alpha = 0
        }
        else {
            colorTableView.delegate = self
            colorTableView.dataSource = self
            colorTableView.frame = CGRect(x: colorTableView.frame.origin.x, y: colorTableView.frame.origin.y, width: colorTableView.frame.size.width, height: colorTableView.contentSize.height)
            if listColor.count <= 4 {
                colorTableViewHeight.constant = CGFloat(listColor.count * 38)
            }
            else {
                colorTableViewHeight.constant = CGFloat(4 * 38)
            }
        }
        
        updateImageUI()
        
        titleStack.layoutIfNeeded()
        titleStack.layoutSubviews()
        nameLabel.text = data?.name
        if data?.brand != nil && data?.brand != "" {
            titleStackBrandView.isHidden = false
            brandLabel.text = data?.brand
        }
        else {
            titleStackBrandView.isHidden = true
            titleStackContainViewHeight.constant = titleStackContainViewHeight.constant - 20
            titleStackContainView.layoutIfNeeded()
        }
        
        updateTitleStack()
        
        descriptionLabel.text = data?.description1
        
        var height: CGFloat = 0
        var isFreeShipping = false
        var freeShippingValue: Int!
        for shipping in (data?.shippingsCost?.listShipping)! {
            if shipping.isPickup! == true {
                let shippingView: TapProductShippingView2 = Bundle.main.loadNibNamed("TapProductShippingView2", owner: nil, options: nil)?.first as! TapProductShippingView2
                shippingView.heightAnchor.constraint(equalToConstant: 20).isActive = true
                shippingView.widthAnchor.constraint(equalToConstant: self.shippingStack.frame.width).isActive = true
                
                shippingView.delegate = self
                shippingView.setData(name: shipping.provider ?? "" + " " + shipping.type!, cashback: shipping.cashbackPercentage!)
                self.shippingStack.addArrangedSubview(shippingView)
                height += 20
            }
            else {
                let shippingView: TapProductShippingView1 = Bundle.main.loadNibNamed("TapProductShippingView1", owner: nil, options: nil)?.first as! TapProductShippingView1
                shippingView.heightAnchor.constraint(equalToConstant: 20).isActive = true
                shippingView.widthAnchor.constraint(equalToConstant: self.shippingStack.frame.width).isActive = true
                
                if shipping.provider != nil && shipping.provider != "" {
                    shippingView.setData(name: shipping.provider ?? "" + " " + shipping.type!, day: shipping.time!, price: shipping.price!)
                }
                else {
                    shippingView.setData(name: shipping.type!, day: shipping.time!, price: shipping.price!)
                }
                self.shippingStack.addArrangedSubview(shippingView)
                height += 20
            }
            if (shipping.freeShippingThreshold != nil && shipping.freeShippingThreshold != 0) {
                isFreeShipping = true
                freeShippingValue = shipping.freeShippingThreshold
            }
        }
        if isFreeShipping {
            let shippingView: TapProductShippingView3 = Bundle.main.loadNibNamed("TapProductShippingView3", owner: nil, options: nil)?.first as! TapProductShippingView3
            shippingView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            shippingView.widthAnchor.constraint(equalToConstant: self.shippingStack.frame.width).isActive = true
            
            shippingView.label.text = "Free shipping for order over S$ \(freeShippingValue ?? 0) in this store"
            self.shippingStack.addArrangedSubview(shippingView)
            height += 20
        }
        shippingViewHeight.constant = height
        shippingStackContainView.layoutIfNeeded()
        
        
        companyImageView.sd_setImage(with: URL.init(string: (data?.sellerPicture)!), completed: nil)
        companyNameLabel.text = data?.sellerName
        companyLocationLabel.text = data?.sellerAddress?.shortDisplayAddress
        
        updateFollowUI()
    }
    
    func updateLikeUI() {
        self.likeImage.image = UIImage.init(named: (self.data?.isLikedByThisUser)! ? "icon_thumbs_on" : "icon_thumbs_off")
        self.likeNumberLabel.text = "\(self.data?.likes ?? 0)"
        if self.data?.isLikedByThisUser == true {
            self.likeNumberLabel.textColor = UIColor.init(netHex: 0x1D6F8B)
        }
        else {
            self.likeNumberLabel.textColor = UIColor.init(netHex: 0x848585)
        }
    }
    
    func updateFollowUI() {
        if (data?.sellerTotalFollower)! > 1 {
            companyFollowerLabel.text = "\(abbreviateNumber(num: data?.sellerTotalFollower ?? 0)) followers"
        }
        else {
            companyFollowerLabel.text = "\(data?.sellerTotalFollower ?? 0) follower"
        }
        if data?.isSellerFollowedByUser == true {
            followButton.backgroundColor = .white
            followButton.layer.borderWidth = 1.0
            followButton.layer.borderColor = UIColor.init(netHex: 0x848585).cgColor
            followButton.setTitle("FOLLOWING", for: .normal)
            followButton.setTitleColor(UIColor.init(netHex: 0x848585), for: .normal)
            //followButton.titleLabel?.textColor = .black //UIColor.init(netHex: 0x848585)
        } else {
            followButton.layer.borderWidth = 0
            followButton.backgroundColor = UIColor.init(netHex: 0x195B79)
            followButton.setTitle("FOLLOW", for: .normal)
            followButton.setTitleColor(UIColor.white, for: .normal)
        }
        followButton.contentHorizontalAlignment = .center
        followButton.titleLabel?.textAlignment = .center
    }
    
    func updateImageUI() {
        items = data?.variations?.listVariations![currentIdex].pictures ?? []
        self.pageControl.numberOfPages = self.items.count
        self.pageControl.currentPage = 0
        self.imagePageView.reloadData()
    }
    
    func updateTitleStack() {
        if data?.variations?.listVariations![currentIdex].salePrice != nil {
            if titleStackDiscountView.isHidden == true {
                titleStackDiscountView.isHidden = false
                titleStackContainViewHeight.constant = titleStackContainViewHeight.constant + 20
                titleStackContainView.layoutIfNeeded()
            }
            let salePrice = Double((data?.variations?.listVariations![currentIdex].salePrice)!)
            let originalPrice = Double((data?.variations?.listVariations![currentIdex].originalPrice)!)
            let percent: Double = Double((salePrice / originalPrice) * 100)
            let roundPercent: Int = Int(round(percent))
            discountedPercentageLabel.text = "-\(100-roundPercent)%"
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "S$\(data?.variations?.listVariations![currentIdex].originalPrice ?? 0)")
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            beforeDiscountedPriceLabel.attributedText = attributeString
            priceLabel.text = "S$\(data?.variations?.listVariations![currentIdex].salePrice ?? 0)"
        }
        else {
            if titleStackDiscountView.isHidden == false {
                titleStackDiscountView.isHidden = true
                titleStackContainViewHeight.constant = titleStackContainViewHeight.constant - 20
                titleStackContainView.layoutIfNeeded()
            }
            priceLabel.text = "S$\(data?.variations?.listVariations![currentIdex].originalPrice ?? 0)"
        }
        if data?.variations?.listVariations![currentIdex].stock != nil && (data?.variations?.listVariations![currentIdex].stock)! > 0 {
            if titleStackOutOfStockView.isHidden == false {
                titleStackOutOfStockView.isHidden = true
                titleStackContainViewHeight.constant = titleStackContainViewHeight.constant - 20
                titleStackContainView.layoutIfNeeded()
            }
        }
        else {
            if titleStackOutOfStockView.isHidden == true {
                titleStackOutOfStockView.isHidden = false
                titleStackContainViewHeight.constant = titleStackContainViewHeight.constant + 20
                titleStackContainView.layoutIfNeeded()
            }
        }
    }
    
    func changeColor() {
        updateTitleStack()
        updateImageUI()
    }
    
    func showLoginPrompt() {
        let alertController = UIAlertController(title: "You need login to continue", message: "Do you want to continue?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { action in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let yesAction = UIAlertAction(title: "Continue", style: .default) { action in
            TAPMainFrame.showLoginPageMain()
        }
        alertController.addAction(yesAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
    
    @IBAction func likeProductButtonTap(_ sender: UIButton) {
        if TAPGlobal.shared.hasLogin() {
            if self.data?.isLikedByThisUser == true {
                TAPWebservice.shareInstance.sendDELETERequest(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/like/\(id ?? "")", responseHandler: { (check, response) in
                    self.data?.likes = response as! Int
                    
                    if self.data?.isLikedByThisUser == true {
                        self.data?.isLikedByThisUser = false
                        self.updateLikeUI()
                    }
                    else {
                        self.data?.isLikedByThisUser = true
                        self.updateLikeUI()
                    }
                })
            }
            else {
                TAPWebservice.shareInstance.sendPUTRequest(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/like/\(id ?? "")", parameters: [:]) { (check, response) in
                    
                    self.data?.likes = response as! Int
                    
                    if self.data?.isLikedByThisUser == true {
                        self.data?.isLikedByThisUser = false
                        self.updateLikeUI()
                    }
                    else {
                        self.data?.isLikedByThisUser = true
                        self.updateLikeUI()
                    }
                }
            }
        }
        else {
            self.showLoginPrompt()
        }
    }
    
    @IBAction func goToCompanyButtonTap(_ sender: UIButton) {
        
    }
    
    
    @IBAction func followCompanyButtonTap(_ sender: UIButton) {
        if TAPGlobal.shared.hasLogin() {
            if self.data?.isSellerFollowedByUser == true {
                TAPWebservice.shareInstance.sendDELETERequest(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/follow/\(data?.sellerId ?? "")", responseHandler: { (check, response) in
                    self.data?.sellerTotalFollower = response as? Int
                    
                    if self.data?.isSellerFollowedByUser == true {
                        self.data?.isSellerFollowedByUser = false
                        self.updateFollowUI()
                    }
                    else {
                        self.data?.isSellerFollowedByUser = true
                        self.updateFollowUI()
                    }
                })
            }
            else {
                TAPWebservice.shareInstance.sendPOSTRequest(path: API_PATH(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "")/follow/\(data?.sellerId ?? "")"), params: [:]) { (check, response) in
                    
                    self.data?.sellerTotalFollower = response
                    
                    if self.data?.isSellerFollowedByUser == true {
                        self.data?.isSellerFollowedByUser = false
                        self.updateFollowUI()
                    }
                    else {
                        self.data?.isSellerFollowedByUser = true
                        self.updateFollowUI()
                    }
                }
            }
        }
        else {
            self.showLoginPrompt()
        }
    }
    
    @IBAction func backButtonTap(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func cartButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func addToCartButtonTap(_ sender: UIButton) {
        
        //setup UI
        if listColor.count == 1 {
            if addToCartColorView.isHidden == false {
                addToCartColorView.isHidden = true
                addToCartViewHeight.constant = addToCartViewHeight.constant - 70
                addToCartView.layoutSubviews()
            }
            self.addToCartSizePickView.isUserInteractionEnabled = true
            self.addToCartQuantityPickView.isUserInteractionEnabled = true
            //đổi màu
        }
        if checkIfHasSize() == false {
            if addToCartSizeView.isHidden == false {
                addToCartSizeView.isHidden = true
                addToCartViewHeight.constant = addToCartViewHeight.constant - 70
                addToCartView.layoutSubviews()
            }
            self.addToCartQuantityPickView.isUserInteractionEnabled = true
            //đổi màu
        }
        
        addToCartColorNameLabel.text = data?.variations?.listVariations![0].colorName
        addToCartColorPreviewView.backgroundColor = UIColor(hexString: (data?.variations?.listVariations![0].colorHexCode)!)
        chooseColorName = data?.variations?.listVariations![0].colorName
        chooseQuantity = 1
        
        
        //setup color drop down
        dropDownColor.anchorView = addToCartColorPickView
        //filter color
        for colorHex in listColor {
            for item in (data?.variations?.listVariations)! {
                if item.colorHexCode == colorHex {
                    dropDownColor.dataSource.append(item.colorName!)
                    break
                }
            }
        }
        dropDownColor.cellNib = UINib(nibName: "TAPAddToCartDropViewCell1", bundle: nil)
        dropDownColor.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? TAPAddToCartDropViewCell1 else { return }
            cell.setColor(color: (self.data?.variations?.listVariations![index].colorHexCode)!)
        }
        dropDownColor.selectionAction = { [unowned self] (index: Int, item: String) in
            self.chooseColorName = item
            self.addToCartColorNameLabel.text = item
            
            for variation in (self.data?.variations?.listVariations)! {
                if variation.colorName == item {
                    self.addToCartColorPreviewView.backgroundColor = UIColor(hexString: variation.colorHexCode!)
                    break
                }
            }
            
            // đổi màu 2 cái dưới
        }
        
        //setup size drop down
        dropDownSize.anchorView = addToCartSizePickView
        //filter size
        if addToCartColorView.isHidden == true {
            for item in (data?.variations?.listVariations)! {
                if item.size != nil && item.size != "" {
                    dropDownSize.dataSource.append(item.size!)
                }
            }
        }
        else {
            for item in (data?.variations?.listVariations)! {
                if item.colorName == chooseColorName {
                    if item.size != nil && item.size != "" {
                        dropDownSize.dataSource.append(item.size!)
                    }
                }
            }
        }
        dropDownSize.cellNib = UINib(nibName: "TAPAddToCartDropViewCell2", bundle: nil)
        dropDownSize.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? TAPAddToCartDropViewCell2 else { return }
            
        }
        dropDownSize.selectionAction = { [unowned self] (index: Int, item: String) in
            self.chooseSize = item
            self.addToCartSizeLabel.text = item
        }
        
        //setup quantity drop down
        dropDownQuantity.anchorView = addToCartQuantityPickView
        dropDownQuantity.dataSource = ["1", "2", "3", "4", "5"]
        dropDownQuantity.cellNib = UINib(nibName: "TAPAddToCartDropViewCell2", bundle: nil)
        dropDownQuantity.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? TAPAddToCartDropViewCell2 else { return }
            
        }
        dropDownQuantity.selectionAction = { [unowned self] (index: Int, item: String) in
            self.chooseQuantity = index + 1
            self.addToCartQuantityLabel.text = item
        }
        
        
        addToCartView.isHidden = false
    }
    
    func showStorePickUp() {
        storePickUpView.isHidden = false
        if data?.sellerAddress?.floor == nil || data?.sellerAddress?.floor == "" || data?.sellerAddress?.unitNumber == nil || data?.sellerAddress?.unitNumber == "" {
            storePickUpLocationLabel.text = "\(data?.sellerAddress?.buildingName ?? "")\n\(data?.sellerAddress?.streetName ?? "")"
        }
        else {
            storePickUpLocationLabel.text = "\(data?.sellerAddress?.buildingName ?? "") #\(data?.sellerAddress?.floor ?? "")-\(data?.sellerAddress?.unitNumber ?? "")\n\(data?.sellerAddress?.streetName ?? "")"
        }
        
        var openString = ""
        for i in 0..<(data?.openingHours?.count)! {
            if i != 0 {
                openString += "\n"
            }
            switch i {
            case 0:
                openString += "Monday: \(data?.openingHours![i] ?? "")"
                break
            case 1:
                openString += "Tuesday: \(data?.openingHours![i] ?? "")"
                break
            case 2:
                openString += "Wednesday: \(data?.openingHours![i] ?? "")"
                break
            case 3:
                openString += "Thursday: \(data?.openingHours![i] ?? "")"
                break
            case 4:
                openString += "Friday: \(data?.openingHours![i] ?? "")"
                break
            case 5:
                openString += "Saturday: \(data?.openingHours![i] ?? "")"
                break
            case 6:
                openString += "Sunday: \(data?.openingHours![i] ?? "")"
                break
            default:
                break
            }
        }
        
        storePickUpOpenTimeLabel.text = openString
    }
    
    @IBAction func storePickUpButtonTap(_ sender: UIButton) {
        storePickUpView.isHidden = true
    }
    
    @objc func colorPickTap(_ sender: UITapGestureRecognizer) {
        
        
        dropDownColor.show()
    }
    
    @objc func sizePickTap(_ sender: UITapGestureRecognizer) {
        
        
        dropDownSize.show()
    }
    
    @objc func quantityPickTap(_ sender: UITapGestureRecognizer) {
        
        
        dropDownQuantity.show()
    }
    @IBAction func addToCartViewButtonTap(_ sender: UIButton) {
        SVProgressHUD.show()
        // /api/v1/u/{userId}/cart/productVariationId/{productVariationId}
        for item in (data?.variations?.listVariations)! {
            if item.colorName == chooseColorName && item.size == chooseSize {
                TAPWebservice.shareInstance.sendPOSTRequest(
                        path: API_PATH(path: "/api/v1/u/\(TAPGlobal.shared.getLoginModel()?.userId ?? "0")/cart/productVariationId/\(item.id ?? 0)"),
                        params: ["quantity": chooseQuantity!],
                        responseHandler: { (check) in
                            SVProgressHUD.dismiss()
                            if check {
                                
                            }
                            else {
                                //show error
                            }
                })
            }
        }
        
        addToCartView.isHidden = true
    }
    
    @objc func hideAddToCartView(_ sender: UITapGestureRecognizer) {
        self.addToCartView.isHidden = true
    }
    
    @objc func hideStorePickupView(_ sender: UITapGestureRecognizer) {
        self.storePickUpView.isHidden = true
    }
    
    func checkIfHasManyColor() -> Bool {
        for item in (data?.variations?.listVariations)! {
            var check = true
            for color in listColor {
                if color == item.colorHexCode {
                    check = false
                    break
                }
            }
            if check {
                listColor.append(item.colorHexCode!)
            }
            
        }
        if listColor.count > 1 {
            return true
        }
        else {
            return false
        }
    }
    
    func checkIfHasSize() -> Bool {
        for item in (data?.variations?.listVariations)! {
            if item.size != nil && item.size != "" {
                chooseSize = item.size
                addToCartSizeLabel.text = item.size
                return true
            }
        }
        return false
    }
    
    func abbreviateNumber(num: Int) -> String {
        // less than 1000, no abbreviation
        if num < 1000 {
            return "\(num)"
        }
        
        // less than 1 million, abbreviate to thousands
        if num < 1000000 {
            var n = Double(num);
            n = Double( floor(n/100)/10 )
            return "\(n.description)k"
        }
        
        // more than 1 million, abbreviate to millions
        var n = Double(num)
        n = Double( floor(n/100000)/10 )
        return "\(n.description)m"
    }
}

extension TAPProductMainPageViewController: iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return items.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            let frame = carousel.frame
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
            itemView.contentMode = .scaleAspectFit
            itemView.layer.masksToBounds = true
        }
        
        itemView.sd_setImage(with: URL.init(string: items[index]), completed: nil)
        return itemView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        pageControl.currentPage = carousel.currentItemIndex
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .wrap) {
            return value * 1.05
            
        } else if (option == .spacing) {
            return 1.0
        } else if (option == .fadeMax) {
            if (carousel.type == .custom) {
                //set opacity based on distance from camera
                return 0.0
            }
            return value;
        }
        return value
    }
    
}

extension TAPProductMainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listColor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TAPProductColorViewCell", for: indexPath) as! TAPProductColorViewCell
        
//        let backgroundView = UIView()
//        backgroundView.backgroundColor = UIColor.clear
//        cell.selectedBackgroundView = backgroundView
        
        cell.setData(hexColor: listColor[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<(data?.variations?.listVariations?.count)! {
            if data?.variations?.listVariations![i].colorHexCode == listColor[indexPath.row] {
                currentIdex = i
                changeColor()
                colorTableView.deselectRow(at: indexPath, animated: false)
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
}

private extension UIColor {
    convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
}
