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
    let accountDAO = AccountDao()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBtn(color: UIColor.brownishGrey)
        self.navigationItem.title = "로그인"
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        LogInBtn.makeRounded(cornerRadius: 5)
        alwaysLogInBtn.setBorder(borderColor: UIColor.blueGrey, borderWidth: 0.5)
       self.emailTF.delegate = self
        self.pwTF.delegate = self
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
    }
    @objc func pop(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: -150)
        })// Move view 150 points upward)
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.transform = CGAffineTransform.identity
        })
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
    @objc func rootPop(){
        
        appDelegate.email = self.emailTF.text!
        self.navigationController?.popToRootViewController(animated: true)
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
        SignIn.shared.signIn(emailTF.text!, pwTF.text!){
            [weak self]
            data in
            
            guard let `self` = self else { return }
            switch data {
            case .success(let res):
                let _res: Token = res as! Token
                print("로그인 성공")
                let added = UIAlertController(title: "로그인 하였습니다.", message: "", preferredStyle: UIAlertController.Style.alert)
                let addedAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { result in self.rootPop()})
                added.addAction(addedAction)
                self.appDelegate.token = _res.token
                self.present(added, animated: true)
               
                
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
