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
    var productCount = 0
    @IBOutlet var setOrderBtn: UIButton!
    @IBOutlet var numOfProducts: UILabel!
    @IBOutlet var productListTV: UITableView!
    @IBOutlet var productTypeCV: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTypeCV.delegate = self
        productTypeCV.dataSource = self
        productListTV.delegate = self
        productListTV.dataSource = self
        navigationItem.title = naviTitle
        setNaviBtn(color: UIColor.darkGrey)
        setTestItems()
        let nibName = UINib(nibName: "PeriodicalCell", bundle: nil)
        productListTV.register(nibName, forCellReuseIdentifier: "PeriodicalCell")
        productCount = products.count
        numOfProducts.text = "\(productCount)개의 상품"
    }
    
    func testfunc() {
        
    }
    func setTestItems() {
        let name = "제주삼다수, 500ml,40개입"
        let brand = "삼다수"
        let pricebefore = "11,700 "
        let price = "10,000"
        let image = "productImg"
        let product = Product(name: name, icon: image, brand: brand, priceBeforeSale: pricebefore, finalPrice: price)!
        for _ in 0 ..< 10 {
            products.append(product)
        }
    }
    func registerTVC() {
        let nibName = UINib(nibName: "PeriodicalTVC", bundle: nil)
        productListTV.register(nibName, forCellReuseIdentifier: "PeriodicalTVC")
        
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

    @IBAction func selectOrder(_ sender: Any) {
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "최신순", style: .default, handler: { result in self.testfunc()}))
        actionSheet.addAction(UIAlertAction(title: "인기순", style: .default, handler: { result in self.testfunc() }))
                actionSheet.addAction(UIAlertAction(title: "가격 낮은순", style: .default, handler: { result in self.testfunc() }))
        actionSheet.addAction(UIAlertAction(title: "가격 높은순", style: .default, handler: { result in self.testfunc() }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension PeriodicalProductVC: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        idx = indexPath.row
        productCount = products.count
        productTypeCV.reloadData()
        productListTV.reloadData()
    }
}
extension PeriodicalProductVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productTypeCV.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! productCell
        cell.productTypeName.text = productTypeList[indexPath.row]
        cell.setBorder(borderColor: UIColor.lightBlueGrey, borderWidth: 0.5)
            if indexPath.row == idx {
                cell.productTypeName.textColor = UIColor.pumpkinOrange
             return cell
        }
            cell.productTypeName.textColor = UIColor.darkGrey
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dvc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        

        navigationController?.pushViewController(dvc, animated: true)
    }
}
extension PeriodicalProductVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productListTV.dequeueReusableCell(withIdentifier: "PeriodicalCell", for: indexPath) as! PeriodicalCell
        cell.productImg.image = UIImage(named: products[indexPath.row].icon!)
        cell.productName.text = products[indexPath.row].name
        cell.productBrand.text = products[indexPath.row].brand
        cell.priceBeforeSale.text = products[indexPath.row].priceBeforeSale
        cell.finalPrice.text = products[indexPath.row].finalPrice
        return cell
    }
    
}

