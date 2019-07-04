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
    var flag = 0
    var product : Product?
    var durationBtns = [UIButton]()
    var count = 1
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
        productBrand.text = product?.brand
        productName.text = product?.name
        priceBeforeSale.text = product?.priceBeforeSale
        finalPrice.text = product?.finalPrice
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
                                      action: #selector(self.pop))
        navigationItem.rightBarButtonItem = cartBTN
        navigationItem.rightBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func purchaseTouched(_ sender: Any) {
         textView.dropShadow(color: UIColor.black, offSet: CGSize(width: 0, height: CGFloat(-2)), opacity: 0.5, radius: 5)
        let height = self.textView.frame.height - self.purchaseBtn.frame.height
         UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.purchaseBtn.transform = CGAffineTransform(translationX: 0, y: self.purchaseBtn.frame.height)
            self.textView.transform = CGAffineTransform(translationX: 0, y: -height)
            
         })
        self.view.layoutIfNeeded()
    }
    
    @IBAction func durationTouched(_ sender: UIButton) {
        let senderBtn = sender.titleLabel?.text
        let previous = flag
        switch senderBtn {
        case "1달에 한 번":
            flag = 0
        case "2달에 한 번":
            flag = 1
        case "3달에 한 번":
            flag = 2
        case "4달에 한 번":
            flag = 3
        default :
            break
        }
        setBtn(btn: durationBtns[previous], color: UIColor.brownishGrey)
        setBtn(btn: durationBtns[flag], color: UIColor.pumpkinOrange)
    }
    @IBAction func countChange(_ sender: Any) {
        count = countStepper.value
        //count따라 totalPrice 변경 구현
    }
}
