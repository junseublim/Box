//
//  SignUp2VC.swift
//  Box
//
//  Created by Jun Seub Lim on 06/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit
import AddressSearchModule

class SignUp2VC: UIViewController, UITextFieldDelegate {

    @IBOutlet var deliveryMemo2TF: UITextField!
    @IBOutlet var receiverTF: UITextField!
    @IBOutlet var num1TF: UITextField!
    @IBOutlet var num2TF: UITextField!
    @IBOutlet var num3TF: UITextField!
    @IBOutlet var delivery1TF: UITextField!
    @IBOutlet var delivery2TF: UITextField!
    @IBOutlet var delivery3TF: UITextField!
    @IBOutlet var oneLabel: UILabel!
    @IBOutlet var twoLabel: UILabel!
    @IBOutlet var deliveryMemo: UIButton!
    @IBOutlet var postSearch: UIButton!
    @IBOutlet var SignUpBtn: UIButton!
    var email : String?
    var password : String?
    var name : String?
    var birth : String?
    var phone : String?
    var gender : Int?
    var receiver : String?
    var receiver_phone : String?
    var address1 : String?
    var address2 : String?
    var address_detail : String?
    var delivery_memo : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        oneLabel.makeRounded(cornerRadius: 10)
        twoLabel.makeRounded(cornerRadius: 10)
        setTFs()
        SignUpBtn.backgroundColor = UIColor.blueGrey
        SignUpBtn.isUserInteractionEnabled = false
        deliveryMemo2TF.isHidden = true
        navigationItem.title = "주문과 동시에 회원가입"
        setNaviBtn(color: UIColor.darkGrey)
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
    func setTFs() {
        num1TF.setBorder(borderColor: UIColor.brownGrey, borderWidth: 1)
        num1TF.makeRounded(cornerRadius: 3)
        num2TF.setBorder(borderColor: UIColor.brownGrey, borderWidth: 1)
        num2TF.makeRounded(cornerRadius: 3)
        num3TF.setBorder(borderColor: UIColor.brownGrey, borderWidth: 1)
        num3TF.makeRounded(cornerRadius: 3)
        delivery1TF.setBorder(borderColor: UIColor.brownGrey, borderWidth: 1)
        delivery1TF.makeRounded(cornerRadius: 3)
        delivery2TF.setBorder(borderColor: UIColor.brownGrey, borderWidth: 1)
        delivery2TF.makeRounded(cornerRadius: 3)
        delivery3TF.setBorder(borderColor: UIColor.brownGrey, borderWidth: 1)
        delivery3TF.makeRounded(cornerRadius: 3)
        receiverTF.setBorder(borderColor: UIColor.brownGrey, borderWidth: 1)
        receiverTF.makeRounded(cornerRadius: 3)
        deliveryMemo.makeRounded(cornerRadius: 3)
        deliveryMemo.setBorder(borderColor: UIColor.brownGrey, borderWidth: 1)
        postSearch.makeRounded(cornerRadius: 3)
        postSearch.setBorder(borderColor: UIColor.pumpkinOrange, borderWidth: 1)
        num1TF.delegate = self
        num2TF.delegate = self
        num3TF.delegate = self
        delivery1TF.delegate = self
        delivery2TF.delegate = self
        delivery3TF.delegate = self
        receiverTF.delegate = self
        //delivery1TF.isUserInteractionEnabled = false
        //delivery2TF.isUserInteractionEnabled = false
        deliveryMemo2TF.setBorder(borderColor: UIColor.brownGrey, borderWidth: 1)
        deliveryMemo2TF.makeRounded(cornerRadius: 3)
        delivery2TF.setBorder(borderColor: UIColor.brownGrey, borderWidth: 1)
        
    }
    
   
    @IBAction func getAddress(_ sender: Any) {
        
    }
    
    @IBAction func goToLogIn(_ sender: Any) {
        self.receiver = receiverTF.text!
        self.receiver_phone = num1TF.text! + num2TF.text! + num3TF.text!
        self.address1 = delivery1TF.text!
        self.address2 = delivery2TF.text!
        self.address_detail = delivery3TF.text!
        if deliveryMemo.titleLabel?.text == "  기타 (직접입력)" {
            self.delivery_memo = deliveryMemo2TF.text!
        }
        else
        {
            self.delivery_memo = self.deliveryMemo.titleLabel?.text
        }
        print(email!,password!,name!,birth!,phone!,gender!,receiver!,receiver_phone!,address1!,address2!,address_detail!,delivery_memo!)
        SignUp.shared.signUp(email!, password!, name!, birth!, phone!, gender!, receiver!, receiver_phone!, address1!, address2!, address_detail!, delivery_memo!) {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            switch data {
            case .success( _):
                print("회원가입 성공")
                let dvc = self.storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
                self.navigationController?.pushViewController(dvc, animated: true)
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
    
    @IBAction func selectMemo(_ sender: Any) {
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "문 앞", style: .default, handler: { result in self.changeLabel(label: "  문 앞")}))
        actionSheet.addAction(UIAlertAction(title: "경비실", style: .default, handler: { result in self.changeLabel(label: "  경비실") }))
        actionSheet.addAction(UIAlertAction(title: "택배함", style: .default, handler: { result in self.changeLabel(label: "  택배함") }))
        actionSheet.addAction(UIAlertAction(title: "직접수령", style: .default, handler: { result in self.changeLabel(label: "  직접수령") }))
        actionSheet.addAction(UIAlertAction(title: "기타 (직접입력)", style: .default, handler: { result in self.changeLabel(label: "  기타 (직접입력)") }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        
    }
    
    func changeLabel(label: String) {
        deliveryMemo.setTitle(label, for: .normal)
        if deliveryMemo.titleLabel?.text == "  기타 (직접입력)" {
            deliveryMemo2TF.isHidden = false
        }
        else
        {
            deliveryMemo2TF.isHidden = true
        }
    }
    
    
    @objc func keyboardWillShow(_ sender: Notification) {
            self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor.darkGrey
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        var next = true
        let tfList = [num1TF,num2TF,num3TF,delivery1TF,delivery2TF,delivery3TF,receiverTF]
        for i in tfList {
            if i?.text?.isEmpty == true
            {
                textField.textColor = UIColor.blueGrey
                next = false
            }
            else {
                textField.textColor = UIColor.darkGrey
            }
        }
        print(next)
        if next == true
        {
            SignUpBtn.isUserInteractionEnabled = true
            SignUpBtn.backgroundColor = UIColor.pumpkinOrange
        }
        else {
            SignUpBtn.isUserInteractionEnabled = false
            SignUpBtn.backgroundColor = UIColor.blueGrey
        }
    }

}
