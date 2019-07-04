//
//  CartVC.swift
//  Box
//
//  Created by Jun Seub Lim on 05/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var cartTV: UITableView!
    var periodicalCart = [CartItem]()
    var packageCart = [CartItem]()
    var cart = [[CartItem]]()
    let header = ["정기배송", "패키지"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("loaded")

       self.cartTV.delegate = self
        self.cartTV.dataSource = self
        let periodicalSample1 = CartItem(name: "제주삼다수, 500ml,40개입", icon: "waterSample", finalPrice: "10,000", count: 2, duration: 0)
          let periodicalSample2 = CartItem(name: "다우니 퍼퓸 콜렉션 섬유유연제 어도러블 2.8L", icon: "84", finalPrice: "8,500", count: 3, duration: 2)
        let packageSample = CartItem(name: "홈카페 5종 컵 세트", icon: "83", finalPrice: "12,000", count: 2, duration: 0)
        periodicalCart.append(periodicalSample1!)
        periodicalCart.append(periodicalSample2!)
        packageCart.append(packageSample!)
                packageCart.append(packageSample!)
                packageCart.append(packageSample!)
        cart.append(periodicalCart)
        cart.append(packageCart)
    registerTVC()
    }
    
    func registerTVC() {
        let nibName = UINib(nibName: "CartPeriodicalTVC", bundle: nil)
        cartTV.register(nibName, forCellReuseIdentifier: "CartPeriodicalTVC")
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        if sectionselected == 0 {
        let cell = cartTV.dequeueReusableCell(withIdentifier: "CartPeriodicalCell", for: indexPath) as! CartPeriodicalCell
        let item = cart[0]
        cell.nameLabel.text = item[indexPath.row].name
            cell.priceLabel.text = item[indexPath.row].finalPrice
            cell.durationBtn.titleLabel?.text = "\(item[indexPath.row].duration! + 1)달에 한 번"
            cell.productImg.image = UIImage(named: item[indexPath.row].icon!)
            cell.countLabel.titleLabel?.text = "\(item[indexPath.row].count!)개"
            return cell
        }
        let cell = cartTV.dequeueReusableCell(withIdentifier: "CartPeriodicalCell", for: indexPath) as! CartPeriodicalCell
        let item = cart[0]
        cell.nameLabel.text = item[indexPath.row].name
        cell.priceLabel.text = item[indexPath.row].finalPrice
        cell.durationBtn.titleLabel?.text = "\(item[indexPath.row].duration! + 1)달에 한 번"
        cell.productImg.image = UIImage(named: item[indexPath.row].icon!)
        cell.countLabel.titleLabel?.text = "\(item[indexPath.row].count!)개"
        return cell
        */
        let cell = cartTV.dequeueReusableCell(withIdentifier: "CartPeriodicalTVC", for: indexPath) as! CartPeriodicalTVC
        return cell
    }
}
