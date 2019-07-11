//
//  ProductDetailVC.swift
//  Box
//
//  Created by Jun Seub Lim on 04/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {
    var viewHeight: CGFloat?
    @IBOutlet var maskingView: UIView!
    @IBOutlet var oneBtn: UIButton!
    @IBOutlet var twoBtn: UIButton!
    @IBOutlet var threeBtn: UIButton!
    @IBOutlet var fourBtn: UIButton!
    @IBOutlet var detailScroll: UIScrollView!
    @IBOutlet var productBrand: UILabel!
    @IBOutlet var saleLabel: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var priceBeforeSale: UILabel!
    @IBOutlet var purchaseBtn: UIButton!
    @IBOutlet var finalPrice: UILabel!
    @IBOutlet var putInCartBtn: UIButton!
    @IBOutlet var countStepper: CSStepper!
    @IBOutlet var productInfoImg: UIImageView!
    @IBOutlet var totalPrice: UILabel!
    @IBOutlet var textView: UIView!
    var product_id : String?
    var price = 0
    var duration = 0
    var durationBtns = [UIButton]()
    var count = 1
    var product_image: String?
    var product_name: String?
    var images : [String]?
    var cart_RegularDAO = Cart_RegularDAO()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        setDurationBtns()
        setPurchaseBtn()
        navigationItem.title = "상품정보"
        setNaviBtn(color: UIColor.darkGrey)
        setLabelsAndImages()
        settextView()
        durationBtns = [oneBtn, twoBtn, threeBtn, fourBtn]
        setRadius()
        countStepper.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 0.5)
        GetRegularDetail.shared.getRegularDetail(product_id!) {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            switch data {
            case .success(let res):
                let _res: RegularDetail = res as! RegularDetail
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                let formattedPriceBeforeSale = formatter.string(from: NSNumber(value: _res.price!))
                let formattedFinalPrice = formatter.string(from: NSNumber(value: _res.saled_price!))
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: formattedPriceBeforeSale!)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                self.productName.text = _res.content
                self.saleLabel.text = String(_res.sale_ratio!) + "%"
                self.priceBeforeSale.attributedText = attributeString
                self.finalPrice.text = formattedFinalPrice
                self.images = _res.content_img
                self.product_image = _res.main_img
                self.product_name = _res.content
                self.productImg.imageFromUrl(_res.main_img)
                self.productBrand.text = _res.name
                self.productInfoImg.imageFromUrl(_res.content_img[0], "")
                self.price = _res.saled_price!
                
                self.totalPrice.text = formattedFinalPrice
                break
            case .requestErr(_):
                print("request error")
                break
            case .pathErr:
                print("path error")
                break
            case .serverErr:
                print("server error")
                break
            case .networkFail:
                print("network fail")
                break
            
            }
        }
    }
    func setRadius() {
        for i in 0 ..< 4 {
            durationBtns[i].makeRounded(cornerRadius: 5.0)
        }
        textView.makeRounded(cornerRadius: 5.0)
    putInCartBtn.makeRounded(cornerRadius: 5.0)
        
        
    }
    func settextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: self.purchaseBtn.topAnchor, constant: 0).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: textView.widthAnchor, multiplier: 323.0/375.0).isActive = true
       
    }
    func setLabelsAndImages() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
     //   let formattedPriceBeforeSale = formatter.string(from: NSNumber(value: product!.priceBeforeSale!))
        //let formattedFinalPrice = formatter.string(from: NSNumber(value: product!.finalPrice!))
        //productBrand.text = product?.brand
        //productName.text = product?.name
       // priceBeforeSale.text = formattedPriceBeforeSale
        //finalPrice.text = formattedFinalPrice
        //할인율, 상품 이미지, 상세정보 이미지는 서버에서 받아오기
    }
    func setPurchaseBtn() {
        purchaseBtn.translatesAutoresizingMaskIntoConstraints = false
        purchaseBtn.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: viewHeight!).isActive = true
        purchaseBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        purchaseBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        purchaseBtn.heightAnchor.constraint(equalTo: purchaseBtn.widthAnchor, multiplier: 16.0/75.0).isActive = true
    }
    func setDurationBtns() {
        setBtn(btn: oneBtn, color: UIColor.pumpkinOrange)
        setBtn(btn: twoBtn, color: UIColor.brownishGrey)
        setBtn(btn: threeBtn, color: UIColor.brownishGrey)
        setBtn(btn: fourBtn, color: UIColor.brownishGrey)
    }
    
    func setBtn(btn: UIButton, color: UIColor) {
        if color == UIColor.brownishGrey{
       
            btn.setTitleColor(UIColor.black, for: .normal)
        }
        else {
            btn.setTitleColor(color, for: .normal)
        }
            btn.setBorder(borderColor: color, borderWidth: 1)
        
    }
    
    func setNaviBtn(color : UIColor){
        
        // 백버튼 이미지 파일 이름에 맞게 변경해주세요.
        let backBTN = UIBarButtonItem(image: UIImage(named: "buttonArrow"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(self.pop))
        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        // 밑에 부분 액션 변경하기(임의로 넣은것)
        let cartBTN = UIBarButtonItem(image: UIImage(named: "cartIcon"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(self.cart))
        navigationItem.rightBarButtonItem = cartBTN
        navigationItem.rightBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    @objc func cart() {
        var dvc : UIViewController?
        if appDelegate.cart[0].isEmpty && appDelegate.cart[1].isEmpty == true {
            dvc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "EmptyVC")
        }
        else {
            dvc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "Cart2VC")
        }
        navigationController?.pushViewController(dvc!, animated: true)
    }
    
    
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func putInCart(_ sender: Any) {
        let result = self.cart_RegularDAO.create(product_id: self.product_id, product_name: self.product_name, product_image: product_image, product_price: price, product_amount: self.count, product_duration: self.duration)
        if result == true {
            for item in appDelegate.cart[0] {
                if item.id == product_id {
                    let rs = self.cart_RegularDAO.remove(product_id: self.product_id!)
                    let failed = UIAlertController(title: "이미 상품이 장바구니에 있습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
                    let addedAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    failed.addAction(addedAction)
                    present(failed, animated: true, completion:  nil)
                    return
                }
            }
            let added = UIAlertController(title: "상품이 장바구니에 담겼습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
            let addedAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            added.addAction(addedAction)
            present(added, animated: true, completion:  nil)
            appDelegate.cart[0].append(CartItem(id: product_id!, name: self.product_name!, image: self.product_image!, price: price, amount: count, duration: duration)!)
            
        }
    }
    @IBAction func purchaseTouched(_ sender: Any) {
        maskingView.isHidden = false
         textView.dropShadow(color: UIColor.black, offSet: CGSize(width: 0, height: CGFloat(-2)), opacity: 0.5, radius: 5)
        let height = self.textView.frame.height - self.purchaseBtn.frame.height
         UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.purchaseBtn.transform = CGAffineTransform(translationX: 0, y: self.purchaseBtn.frame.height)
            self.textView.transform = CGAffineTransform(translationX: 0, y: -height)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            self.maskingView.addGestureRecognizer(tapGesture)
            
            
        
         })
        self.view.layoutIfNeeded()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        textView.dropShadow(color: UIColor.black, offSet: CGSize(width: 0, height: 0), opacity: 0, radius: 0)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.purchaseBtn.transform = .identity
            self.textView.transform = .identity
        })
        self.view.layoutIfNeeded()
        maskingView.isHidden = true
    }
    @IBAction func durationTouched(_ sender: UIButton) {
        let senderBtn = sender.titleLabel?.text
        let previous = duration
        switch senderBtn {
        case "1달에 한 번":
            duration = 0
        case "2달에 한 번":
            duration = 1
        case "3달에 한 번":
            duration = 2
        case "4달에 한 번":
            duration = 3
        default :
            break
        }
        setBtn(btn: durationBtns[previous], color: UIColor.brownishGrey)
        setBtn(btn: durationBtns[duration], color: UIColor.pumpkinOrange)
    }
    @IBAction func countChange(_ sender: Any) {
        count = countStepper.value
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let tempTotalPrice = count * self.price
        let formattedTotalPrice = formatter.string(from: NSNumber(value: tempTotalPrice))
        totalPrice.text = formattedTotalPrice
    }
}
