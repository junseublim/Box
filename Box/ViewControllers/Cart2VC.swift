//
//  CartVC.swift
//  Box
//
//  Created by Jun Seub Lim on 05/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class Cart2VC: UIViewController, UITableViewDelegate, UITableViewDataSource, CartPeriodicalCellDelegate, CartPackageCellDelegate {

    
    typealias Cart_RegularRecord = (String,Int, Int)
    typealias Cart_PackageRecord = (String,Int)
    @IBOutlet var countPicker: UIPickerView!
    
    @IBOutlet var pickerTool: UIToolbar!
    @IBOutlet var doneBtn: UIBarButtonItem!
    @IBOutlet var CartTV: UITableView!
    @IBOutlet var selectAllBtn: UIButton!
    @IBOutlet var totalPrice: UILabel!
    @IBOutlet var orderBtn: UIButton!
    
    let pickerTitle = [1,2,3,4,5,6,7,8]
    let header = ["정기배송", "패키지"]
    var sectionSelected =  0
    var selectAllBool = true
   // var selectedPeriodical = [Bool]()
   // var selectedEach = [[Bool]]()
   // var selectedPackage = [Bool]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cart_RegularDAO = Cart_RegularDAO()
    let cart_PackageDAO = Cart_PackageDAO()
    var toolBar = UIToolbar()
    var picker  : UIPickerView?
    var pickerReturnValue : Int = 1
    var tempSection: Int?
    var tempRow: Int?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.CartTV.delegate = self
        self.CartTV.dataSource = self
        countPicker.delegate = self
        countPicker.dataSource = self
        countPicker.isHidden = true
        pickerTool.isHidden = true
        registerTVC()
       // selectAllBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
        checkAllSelected()
        selectAllBtn.makeRounded(cornerRadius: 1)
        selectAllBtn.setBorder(borderColor: UIColor.black, borderWidth: 1)
        orderBtn.makeRounded(cornerRadius: 5)
        navigationItem.title = "장바구니"
        setNaviBtn(color: UIColor.darkGrey)
        /*
        selectedEach.append(selectedPeriodical)
        selectedEach.append(selectedPackage)
        for _ in appDelegate.cart[0] {
            selectedPeriodical.append(true)
        }
        for _ in appDelegate.cart[1] {
            selectedPackage.append(true)
        }
         */
        addAllprices()
        
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
    
    @IBAction func selectedAll(_ sender: Any) {
        if selectAllBool == true {
            selectAllBool = false
            selectAllBtn.setImage(UIImage(named: ""), for: .normal)
            for cart1 in appDelegate.cart {
                for cart2 in cart1 {
                    cart2.selected = false
                }
            }
        }
        else {
            selectAllBool = true
            selectAllBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
            for cart1 in appDelegate.cart {
                for cart2 in cart1 {
                    cart2.selected = true
                }
            }
        }
        addAllprices()
        CartTV.reloadData()
    }
    func changeLabel() {
        
    }
   
    
    func addAllprices() {
        var totalprice  = 0
        for cart1 in appDelegate.cart {
            for cart2 in cart1 {
                if cart2.selected == true {
                totalprice = totalprice + cart2.price! * cart2.amount!
                }
            }
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedprice = formatter.string(from: NSNumber(value: totalprice))
        totalPrice.text = formattedprice
    }
    func registerTVC() {
        let nibName = UINib(nibName: "CartPeriodicalCell", bundle: nil)
        CartTV.register(nibName, forCellReuseIdentifier: "CartPeriodicalCell")
        let nibName1 = UINib(nibName: "CartPackageCell", bundle: nil)
        CartTV.register(nibName1, forCellReuseIdentifier: "CartPackageCell")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    func checkAllSelected() {
        for cart1 in appDelegate.cart {
            for cart2 in cart1 {
                if cart2.selected == false {
                    selectAllBool = false
                    selectAllBtn.setImage(UIImage(named: ""), for: .normal)
                    return
                }
            }
        }
        selectAllBool = true
        print("All selected!")
        selectAllBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
        addAllprices()
        return
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("######num of rows!#####")
        print(appDelegate.cart[section].count)
        return appDelegate.cart[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        sectionSelected = indexPath.section
        if sectionSelected == 0 {
         let cell = CartTV.dequeueReusableCell(withIdentifier: "CartPeriodicalCell", for: indexPath) as! CartPeriodicalCell
         let cart1 = appDelegate.cart[0]
            let formattedFinalPrice = formatter.string(from: NSNumber(value:cart1[indexPath.row].price!))
            cell.nameLabel.text = cart1[indexPath.row].name
            cell.priceLabel.text = formattedFinalPrice
            cell.durationBtn.isHidden = false
            cell.durationBtn.setTitle("  \(cart1[indexPath.row].duration! + 1)달에 한 번", for: .normal)
            
            cell.productImg.imageFromUrl(cart1[indexPath.row].image!)
            cell.countBtn.setTitle("\(cart1[indexPath.row].amount!)개", for: .normal)
            cell.section = indexPath.section
            cell.row = indexPath.row
            if cart1[indexPath.row].selected == true {
                print("selected!")
                cell.selectBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
            }
            else {
                print("not selected!")
                cell.selectBtn.setImage(UIImage(named: ""), for: .normal)
            }
            cell.delegate = self
        return cell
        }
        let cell = CartTV.dequeueReusableCell(withIdentifier: "CartPackageCell", for: indexPath) as! CartPackageCell
        let cart2 = appDelegate.cart[1]
        let formattedFinalPrice = formatter.string(from: NSNumber(value:cart2[indexPath.row].price!))
        cell.nameLabel.text = cart2[indexPath.row].name
        cell.priceLabel.text = formattedFinalPrice
        cell.durationBtn.isHidden = true
        cell.productImg.imageFromUrl(cart2[indexPath.row].image!)
        cell.countBtn.setTitle("\(cart2[indexPath.row].amount!)개", for: .normal)
        cell.section = indexPath.section
        cell.row = indexPath.row
        if cart2[indexPath.row].selected == true {
            cell.selectBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
        }
        else {
            
            cell.selectBtn.setImage(UIImage(named: ""), for: .normal)
        }
        cell.delegate = self
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return appDelegate.cart.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        headerView.backgroundColor = UIColor.veryLightPink
        headerView.textLabel?.font = UIFont(name: "NotoSans-Bold.ttf", size: 18)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = 170/596 * self.CartTV.frame.height
        return height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            let cell = CartTV.cellForRow(at: indexPath) as! CartPeriodicalCell
            if appDelegate.cart[indexPath.section][indexPath.row].selected == true {
                appDelegate.cart[indexPath.section][indexPath.row].selected = false
                cell.selectBtn.setImage(UIImage(named: ""), for: .normal)
            }
            else {
                appDelegate.cart[indexPath.section][indexPath.row].selected = true
                cell.selectBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
            }
        case 1:
             let cell = CartTV.cellForRow(at: indexPath) as! CartPackageCell
             if appDelegate.cart[indexPath.section][indexPath.row].selected == true {
                appDelegate.cart[indexPath.section][indexPath.row].selected = false
                cell.selectBtn.setImage(UIImage(named: ""), for: .normal)
             }
             else {
                appDelegate.cart[indexPath.section][indexPath.row].selected = true
                cell.selectBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
            }
        default:
            break
        }
        
        checkAllSelected()
        addAllprices()
        
        }
    
    func CartPackageCell(_ CartPackageCell: CartPackageCell, countTouchedFor1 section: Int, countTouchedFor2 row: Int) {
        countPicker.isHidden = false
        pickerTool.isHidden = false
        tempRow = row
        tempSection = section
    }
    
    func CartPackageCell(_ CartPackageCell: CartPackageCell, cancelTouchedFor1 section: Int, cancelTouchedFor2 row: Int) {
        let rs = cart_PackageDAO.remove(package_id:  appDelegate.cart[section][row].id!)
        if rs == false {
            print("삭제 실패!")
            return
        }
        appDelegate.cart[1].remove(at: row)
        CartTV.reloadData()
        addAllprices()
    }
    
    func CartPeriodicalCell(_ CartPeriodicalCell: CartPeriodicalCell, cancelTouchedFor1 section: Int, cancelTouchedFor2 row: Int){
 
            let rs = cart_RegularDAO.remove(product_id: appDelegate.cart[section][row].id!)
            if rs == false {
                print("삭제 실패!")
                return
            }
        appDelegate.cart[0].remove(at: row)
        CartTV.reloadData()
        addAllprices()
    }
    
    func CartPeriodicalCell(_ CartPeriodicalCell: CartPeriodicalCell, durationTouchedFor1 section: Int, durationTouchedFor2 row: Int){
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "1달에 한 번", style: .default, handler: { result in self.changeDuration(section: section, row: row, duration: 0)}))
        actionSheet.addAction(UIAlertAction(title: "2달에 한 번", style: .default, handler: { result in self.changeDuration(section: section, row: row,  duration: 1)}))
        actionSheet.addAction(UIAlertAction(title: "3달에 한 번", style: .default, handler: { result in self.changeDuration(section: section, row: row, duration: 2)}))
        actionSheet.addAction(UIAlertAction(title: "4달에 한 번", style: .default, handler: { result in self.changeDuration(section: section, row: row, duration: 3) }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    func CartPeriodicalCell(_ CartPeriodicalCell: CartPeriodicalCell, countTouchedFor1 section: Int, countTouchedFor2 row: Int) {
        countPicker.isHidden = false
        pickerTool.isHidden = false
        tempRow = row
        tempSection = section
    
    }

    func changeDuration(section: Int, row: Int, duration: Int) {
        appDelegate.cart[section][row].duration = duration
        let indexPath = IndexPath(row: row, section: section)
        CartTV.reloadRows(at: [indexPath], with: .none)
    }
    @IBAction func goToSignUp(_ sender: Any) {
        if appDelegate.cart[0].isEmpty && appDelegate.cart[1].isEmpty {
            let noItem = UIAlertController(title: "장바구니가 비었습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
            let addedAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            noItem.addAction(addedAction)
            present(noItem, animated: true, completion:  nil)
            return
        }
        if appDelegate.token == nil {
        let dvc = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "SignUp1VC") as! SignUp1VC
          navigationController?.pushViewController(dvc, animated: true)
        }
        else {
            let dvc = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    @IBAction func onDoneBtnTapped(_ sender: Any) {
        print("tapped")
        countPicker.isHidden = true
        pickerTool.isHidden = true
        appDelegate.cart[tempSection!][tempRow!].amount = pickerReturnValue
        let indexPath = IndexPath(row: tempRow!, section: tempSection!)
        CartTV.reloadRows(at: [indexPath], with: .none)
        addAllprices()
    }
    
}
    
extension Cart2VC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerTitle.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("\(row)")
        return String(pickerTitle[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerReturnValue = pickerTitle[row]
        print(pickerReturnValue)
    }
}
