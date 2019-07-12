//
//  MyBoxVC.swift
//  Box
//
//  Created by Jun Seub Lim on 12/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class MyBoxVC: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var logOutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setNaviBtn(color: UIColor.brownishGrey)
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
                                      action: #selector(self.push))
        navigationItem.rightBarButtonItem = cartBTN
        navigationItem.rightBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func push() {
        var dvc : UIViewController?
        if appDelegate.cart[0].isEmpty && appDelegate.cart[1].isEmpty == true {
            dvc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "EmptyVC")
        }
        else {
            dvc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "Cart2VC")
        }
        navigationController?.pushViewController(dvc!, animated: true)
    }
    
    @IBAction func logOut(_ sender: Any) {
        
    }
    
}
