//
//  PeriodicalProductVC.swift
//  Box
//
//  Created by Jun Seub Lim on 03/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class PeriodicalProductVC: UIViewController {
    var productTypeList = [String]()
    var idx : Int?
    var naviTitle: String?
    var products = [Product]()
    @IBOutlet var productListTV: UITableView!
    @IBOutlet var productTypeCV: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTypeCV.delegate = self
        self.productTypeCV.dataSource = self
        self.productListTV.delegate = self
        self.productListTV.dataSource = self
        navigationItem.title = naviTitle
        setNaviBtn(color: UIColor.darkGrey)
        setTestItems()
        registerTVC()
    }
    func setTestItems() {
        let name = "제주삼다수, 500ml,40개입"
        let brand = "삼다수"
        let pricebefore = "11,700 "
        let price = "10,000원"
        let image = "productImg"
        let product = Product(name: name, icon: image, brand: brand, priceBeforeSale: pricebefore, finalPrice: price)
        for _ in 0 ..< 5 {
            products.append(product!)
        }
        print(products[0].name, products[0].icon)
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
    func registerTVC() {
        
        /*
         xib 로 만들어진 UITableViewCell 을 사용하기 위해서는 아래와 같은 절차가 필요합니다.
         nibName 에는 *.xib 의 이름을 입력합니다.
         forCellReuseIdentifier 에는 *.xib 의 reuseIdentifier 를 입력합니다.
         */
        let nibName = UINib(nibName: "PeriodicalTVC", bundle: nil)
        productListTV.register(nibName, forCellReuseIdentifier: "PeriodicalTVC")
 
    }
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
}
extension PeriodicalProductVC : UICollectionViewDelegate {
    
}
extension PeriodicalProductVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productTypeCV.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! productCell
        cell.productTypeName.text = productTypeList[indexPath.row]
        return cell
    }
    
    
}
extension PeriodicalProductVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = (productTypeCV.frame.width) / 4
        let height : CGFloat = (productTypeCV.frame.height) / 2
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension PeriodicalProductVC : UITableViewDelegate {
    
    
}
extension PeriodicalProductVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if naviTitle == "정기배송" {
        let cell = productListTV.dequeueReusableCell(withIdentifier: "PeriodicalTVC", for: indexPath) as! PeriodicalTVC
       cell.productName.text = products[indexPath.row].name
        cell.productImg.image = UIImage(named: products[indexPath.row].icon!)
        cell.priceBeforeSale.text = products[indexPath.row].priceBeforeSale!
        cell.finalPrice.text = products[indexPath.row].finalPrice!
        cell.productBrand.text = products[indexPath.row].brand!
            return cell
        }
            //밑에 변경
            let cell = productListTV.dequeueReusableCell(withIdentifier: "PeriodicalTVC", for: indexPath) as! PeriodicalTVC
            cell.productName.text = products[indexPath.row].name
            cell.productImg.image = UIImage(named: products[indexPath.row].icon!)
            cell.priceBeforeSale.text = products[indexPath.row].priceBeforeSale
            cell.finalPrice.text = products[indexPath.row].finalPrice
            cell.productBrand.text = products[indexPath.row].brand
            return cell
    }
    
    
}

