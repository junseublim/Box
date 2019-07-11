//
//  LogInVC.swift
//  
//
//  Created by Jun Seub Lim on 07/07/2019.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var pwTF: UITextField!
    
    @IBOutlet var alwaysLogInBtn: UIButton!
    @IBOutlet var alwaysLogInLabelBtn: UIButton!
    @IBOutlet var LogInBtn: UIButton!
    @IBOutlet var findIdBtn: UIButton!
    @IBOutlet var resetPwBtn: UIButton!
    var alwaysLogInBool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        LogInBtn.makeRounded(cornerRadius: 5)
        alwaysLogInBtn.setBorder(borderColor: UIColor.blueGrey, borderWidth: 0.5)
       self.emailTF.delegate = self
        self.pwTF.delegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        
    }
    @objc func keyboardWillShow(_ sender: Notification) {
            self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.white
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            textField.backgroundColor = UIColor(displayP3Red: 243 / 255, green: 243 / 255, blue: 243 / 255, alpha: 1.0)
        }
    }
    @IBAction func test(_ sender: Any) {
        let dvc = UIStoryboard(name: "Payment", bundle: nil).instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        self.present(dvc, animated: true)
        
    }
    
    @IBAction func alwaysLogIn(_ sender: Any) {
        print("func called")
        if alwaysLogInBool == true {
                alwaysLogInBool = false
            print("change to false, set image to blank")
             alwaysLogInBtn.setImage(UIImage(named: ""), for: .normal)
        }
else {
            print("changed to true, check icon")
            alwaysLogInBool = true
            alwaysLogInBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
      }
    }
    @IBAction func logInBtn(_ sender: Any) {
        print("saved")
        SignIn.shared.signUp(emailTF.text!, pwTF.text!){
            [weak self]
            data in
            
            guard let `self` = self else { return }
            switch data {
            case .success(let res):
                print("로그인 성공")
                let _res: Token = res as! Token
                self.appDelegate.token = _res.token
                print(self.appDelegate.token!)
                self.performSegue(withIdentifier: "unwindToHome", sender: self)
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

}
