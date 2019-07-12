//
//  PaymentVC.swift
//  Box
//
//  Created by Jun Seub Lim on 07/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit
class PaymentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

   

    @IBOutlet var paymentTV: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cartCount = 0
    let account = Account(email: "powe0112@gmail.com", name: "손수영", phone: 01065329657, recipient: "손수영", phoneDelivery: 01065329657, delivery1: "22211", delivery2: "인천광역시 미추홀구 재넘이길 147-17", delivery3: "문화네트빌 202동 403호", deliveryMemo: "  문 앞", deliveryDate: 20, token: nil)
    var productInfo = true
    var customerInfo = true
    var deliveryInfo = true
    var deliveryDateInfo = true
    var paymentInfo = true
    var totalPriceInfo = true
    var totalPrice = 0
    let formatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTVC()
        paymentTV.delegate = self
        paymentTV.dataSource = self
        cartCount = appDelegate.cart[0].count + appDelegate.cart[1].count
        formatter.numberStyle = .decimal
        setNaviBtn(color: UIColor.darkGrey)
        navigationItem.title = "주문 결제"
        var cart = [CartItem]()
        for i in appDelegate.cart {
            for j in i {
                cart.append(j)
            }
        }
        for item in cart {
            totalPrice += item.price! * item.amount!
        }
    }
    func setNaviBtn(color: UIColor) {
        let backBTN = UIBarButtonItem(image: UIImage(named: "buttonArrow"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(self.pop))
        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    func registerTVC() {
        let nibName1 = UINib(nibName: "RegularDateCell", bundle: nil)
        paymentTV.register(nibName1, forCellReuseIdentifier: "RegularDateCell")
        let nibName2 = UINib(nibName: "PaymentCell", bundle: nil)
        paymentTV.register(nibName2, forCellReuseIdentifier: "PaymentCell")
        let nibName3 = UINib(nibName: "TotalPriceCell", bundle: nil)
        paymentTV.register(nibName3, forCellReuseIdentifier: "TotalPriceCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && productInfo { return cartCount + 2}
        if section == 1 && customerInfo { return 3}
        if section == 2 && deliveryInfo { return 3}
        if section == 3 && deliveryDateInfo { return 3}
        if section == 4 && paymentInfo { return 3}
        if section == 5 && totalPriceInfo { return 2}
        if section == 5 {
            return 1
        }
        
        return 2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if indexPath.section == 0 {productInfo = !productInfo}
            else if indexPath.section == 1 {customerInfo = !customerInfo}
            else if indexPath.section == 2 {deliveryInfo = !deliveryInfo}
            else if indexPath.section == 3 {deliveryDateInfo = !deliveryDateInfo}
            else if indexPath.section == 4 {paymentInfo = !paymentInfo}
            else if indexPath.section == 5 {totalPriceInfo = !totalPriceInfo}
            let section = IndexSet.init(integer: indexPath.section)
            paymentTV.reloadSections(section, with: .none)
            }
        
        }
    
    @IBAction func PurchaseBtn(_ sender: Any) {
        let dvc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "OrderResultVC") as! OrderResultVC
        var cart = [CartItem]()
        for i in appDelegate.cart {
            for j in i {
                cart.append(j)
            }
        }
        dvc.TotalPrice = self.totalPrice
        dvc.count = self.cartCount - 1
        dvc.firstItem = cart[0].name
        self.present(dvc, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        headerView.textLabel?.font = UIFont(name: "NotoSans-Bold.ttf", size: 18)
        return headerView
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionHeader = ["주문상품 정보", "주문자 정보", "배송지 정보", "정기 배송일 설정", "결제 수단", "최종 결제금액"]
        return sectionHeader[section]
    }
 */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cart = [CartItem]()
        for i in appDelegate.cart {
            for j in i {
                cart.append(j)
            }
        }

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentHeaderCell", for: indexPath) as! PaymentHeaderCell
                cell.headerLabel.text = "주문상품 정보"
                return cell
            }
            else if indexPath.row == cartCount + 1 || (indexPath.row == 1 && !productInfo ) {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "separationCell", for: indexPath)
                return cell
            }
            let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentCartCell", for: indexPath) as! PaymentCartCell
            for item in appDelegate.cart[1] {
                if item.id == cart[indexPath.row-1].id
                {
                    let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentCartCell2", for: indexPath) as! PaymentCartCell2
                    let formattedPrice = formatter.string(from: NSNumber(value: cart[indexPath.row-1].price!))
                    cell.productName.text = cart[indexPath.row-1].name
                    cell.productPrice.text = formattedPrice
                    cell.productImage.imageFromUrl(cart[indexPath.row-1].image)
                    cell.productAmount.text = String(cart[indexPath.row-1].amount!) + "개"
                    return cell
                }
            }
            let formattedPrice = formatter.string(from: NSNumber(value: cart[indexPath.row-1].price!))
            cell.productName.text = cart[indexPath.row-1].name
            cell.productPrice.text = formattedPrice
            cell.productImage.imageFromUrl(cart[indexPath.row-1].image)
            cell.productAmount.text = String(cart[indexPath.row-1].amount!) + "개"
            return cell
            
        }
        else if indexPath.section == 1{
            if indexPath.row == 0 {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentHeaderCell", for: indexPath) as! PaymentHeaderCell
                cell.headerLabel.text = "주문자 정보"
                return cell
            }
            else if indexPath.row == 2 || (indexPath.row == 1 && !customerInfo ) {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "separationCell", for: indexPath)
                return cell
            }
            let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentOrdererCell", for: indexPath) as! PaymentOrdererCell
            cell.emailTF.text = account.email
            cell.ordererLabel.text = account.name
            cell.phone1TF.text = "010"
            cell.phone2TF.text = "6532"
            cell.phone3TF.text = "9657"
            return cell
        }
        else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentHeaderCell", for: indexPath) as! PaymentHeaderCell
                cell.headerLabel.text = "배송지 정보"
                return cell
            }
            else if indexPath.row == 2 || (indexPath.row == 1 && !deliveryInfo ) {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "separationCell", for: indexPath)
                return cell
            }
            let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentRecipientCell", for: indexPath) as! PaymentRecipientCell
            cell.recipientTF.text = "손수영"
            cell.address1TF.text = account.delivery1
            cell.address2TF.text = account.delivery2
            cell.address3TF.text = account.delivery3
            cell.phone1TF.text = "010"
            cell.phone2TF.text = "6532"
            cell.phone3TF.text = "9657"
            cell.deliveryMemoBtn.setTitle(account.deliveryMemo, for: .normal)
            return cell
        }
        else if indexPath.section == 3 {
            if indexPath.row == 0 {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentHeaderCell", for: indexPath) as! PaymentHeaderCell
                cell.headerLabel.text = "정기 배송일 설정"
                return cell
            }
            else if indexPath.row == 2 || (indexPath.row == 1 && !deliveryDateInfo ) {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "separationCell", for: indexPath)
                return cell
            }
            let cell = paymentTV.dequeueReusableCell(withIdentifier: "RegularDateCell", for: indexPath) as! RegularDateCell
            return cell
        }
        else if indexPath.section == 4 {
            if indexPath.row == 0 {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentHeaderCell", for: indexPath) as! PaymentHeaderCell
                cell.headerLabel.text = "결제 수단"
                return cell
            }
            else if indexPath.row == 2 || (indexPath.row == 1 && !paymentInfo ) {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "separationCell", for: indexPath)
                return cell
            }
            let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentCell
            return cell
        }
        else if indexPath.section == 5 {
            if indexPath.row == 0 {
                let cell = paymentTV.dequeueReusableCell(withIdentifier: "PaymentHeaderCell", for: indexPath) as! PaymentHeaderCell
                cell.headerLabel.text = "최종 결제금액"
                return cell
            }
            let cell = paymentTV.dequeueReusableCell(withIdentifier: "TotalPriceCell", for: indexPath) as! TotalPriceCell
            let formattedTotalPrice = formatter.string(from: NSNumber(value: totalPrice))
            cell.beforeDelivery.text = formattedTotalPrice
            cell.afterDelivery.text = formattedTotalPrice
            return cell
        }
        let cell = paymentTV.dequeueReusableCell(withIdentifier: "Cell")
        return cell!
    }
    
}
