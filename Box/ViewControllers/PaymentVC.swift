//
//  PaymentVC.swift
//  Box
//
//  Created by Jun Seub Lim on 07/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit
class PaymentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    typealias Cart_RegularRecord = (String,String,String,Int,Int, Int)
    typealias Cart_PackageRecord = (String,String,String, Int,Int)

    @IBOutlet var paymentTV: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cartCount = 0
    var productInfo = true
    var customerInfo = true
    var deliveryInfo = true
    var deliveryDateInfo = true
    var paymentInfo = true
    var totalPriceInfo = true
    var totalPrice = 0
    let formatter = NumberFormatter()
    let cart_RegularDAO = Cart_RegularDAO()
    let cart_PackageDAO = Cart_PackageDAO()
    var cart = [CartItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTVC()
        paymentTV.delegate = self
        paymentTV.dataSource = self
        formatter.numberStyle = .decimal
        setNaviBtn(color: UIColor.darkGrey)
        navigationItem.title = "주문 결제"
        
        for i in appDelegate.cart {
            for j in i {
                if j.selected == true {
                cart.append(j)
                }
            }
        }
        cartCount = cart.count
        for item in cart {
            totalPrice += item.price! * item.amount!
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if appDelegate.PurchaseDone == true {
            appDelegate.PurchaseDone = false
            self.navigationController?.popToRootViewController(animated: true)
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
        dvc.TotalPrice = self.totalPrice
        dvc.count = self.cartCount - 1
        dvc.firstItem = cart[0].name
        
        for item in appDelegate.cart[0] {
            if item.selected! {
                let rs = cart_RegularDAO.remove(product_id: item.id!)
            }
        }
        for item in appDelegate.cart[1] {
            if item.selected! {
                let rs = cart_PackageDAO.remove(package_id: item.id!)
            }
        }
        appDelegate.cart[0].removeAll()
        appDelegate.cart[1].removeAll()
        let RegularItems : [Cart_RegularRecord] = cart_RegularDAO.find()
        let PackageItems : [Cart_PackageRecord] = cart_PackageDAO.find()
        for regularitem in RegularItems {
            print("appendingRegularItem")
            print(regularitem)
            appDelegate.cart[0].append(CartItem(id: regularitem.0, name: regularitem.1, image: regularitem.2, price: regularitem.3, amount: regularitem.4, duration: regularitem.5)! )
        }
        for packageitem in PackageItems {
            print("appendingPackageItem")
            print(packageitem)
            appDelegate.cart[1].append(CartItem(id: packageitem.0,name: packageitem.1,image: packageitem.2, price: packageitem.3, amount: packageitem.4)!)
        }
        
        appDelegate.PurchaseDone = true
        self.present(dvc, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    /*    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
            let phone = appDelegate.tempAccount.phone!
            let middle1Idx : String.Index = phone.index(phone.startIndex, offsetBy: 3)
            let middle2Idx : String.Index = phone.index(phone.startIndex, offsetBy: 7)
            let endIdx: String.Index = phone.index(before: phone.endIndex)
            //let startIdx = phone.index(after: phone.startIndex)
            let phone1 = phone[phone.startIndex ..< middle1Idx]
            let phone2 = phone[middle1Idx ..< middle2Idx]
            let phone3 = phone[middle2Idx ..< endIdx]
            cell.emailTF.text = appDelegate.tempAccount.email!
            cell.ordererLabel.text = appDelegate.tempAccount.name!
            cell.phone1TF.text = String(phone1)
            cell.phone2TF.text = String(phone2)
            cell.phone3TF.text = String(phone3)
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
            let phone = appDelegate.tempAccount.phoneDelivery!
            let middle1Idx : String.Index = phone.index(phone.startIndex, offsetBy: 3)
            let middle2Idx : String.Index = phone.index(phone.startIndex, offsetBy: 7)
            let endIdx: String.Index = phone.index(before: phone.endIndex)
            //let startIdx = phone.index(after: phone.startIndex)
            let phone1 = phone[phone.startIndex ..< middle1Idx]
            let phone2 = phone[middle1Idx ..< middle2Idx]
            let phone3 = phone[middle2Idx ..< endIdx]
            cell.recipientTF.text = "손수영"
            cell.address1TF.text = appDelegate.tempAccount.delivery1!
            cell.address2TF.text = appDelegate.tempAccount.delivery2!
            cell.address3TF.text = appDelegate.tempAccount.delivery3!
            cell.phone1TF.text = String(phone1)
            cell.phone2TF.text = String(phone2)
            cell.phone3TF.text = String(phone3)
            cell.deliveryMemoBtn.setTitle(appDelegate.tempAccount.deliveryMemo, for: .normal)
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
