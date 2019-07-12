//
//  EmptyCartVC.swift
//  Box
//
//  Created by Jun Seub Lim on 07/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class EmptyCartVC: UIViewController {

    @IBOutlet var shopBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBtn(color: UIColor.darkGrey)
        navigationItem.title = "장바구니"
        shopBtn.makeRounded(cornerRadius: 5)
    }
    

    @IBAction func goToShopping(_ sender: Any) {
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
    }
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }

 
    @IBAction func goShopping(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
