//
//  PeriodicalProductVC.swift
//  Box
//
//  Created by Jun Seub Lim on 03/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit
import Kingfisher

class PeriodicalProductVC: UIViewController {
    
    var productTypeList = [String]()
    var idx : Int?
    var naviTitle: String?
    var productlist = [Product]()
    var productCount = 0
    var buttonselection : Int?
    var flag = 1
    let periodicNamesToSend = ["생수/음료", "세제/섬유유연제", "욕실용품","휴지/물티슈", "청소용품", "주방용품","디퓨저/방향제", "반려동물용품"]
    let packageNamesToSend = [ "공간확보의 달인","가전제품", "우리 집 관리", "홈카페", "포근하게 자기","입는건 중요해",  "반려동물과 함께", "특별기획"]
    @IBOutlet var setOrderBtn: UIButton!
    @IBOutlet var numOfProducts: UILabel!
    @IBOutlet var productListTV: UITableView!
    @IBOutlet var productTypeCV: UICollectionView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTypeCV.delegate = self
        productTypeCV.dataSource = self
        productListTV.delegate = self
        productListTV.dataSource = self
        navigationItem.title = naviTitle
        setNaviBtn(color: UIColor.darkGrey)
        //setTestItems()
        registerTVC()
        getItems(idx: idx!, flag: flag)
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let index = productListTV.indexPathForSelectedRow {
            productListTV.deselectRow(at: index, animated: true)
        }
    }

    func getItems(idx : Int, flag: Int) {
        var category : String?
        if buttonselection == 0 {
            category = periodicNamesToSend[idx]
        GetRegularList.shared.getRegularList(category!, flag){
            [weak self]
            data in
            
        guard let `self` = self else { return }
            switch data {
            case .success(let res):
                
                let _res: ResponseRegular<Regular> = res as! ResponseRegular<Regular>
                self.productCount = _res.product_count
                let item : [Regular] = _res.product!
                var tempProducts = [Product]()
                for i in _res.product! {
                    let brand = i.name
                    let name = i.content
                    let priceBeforeSale = i.price
                    let finalPrice = i.saled_price
                    let image = i.main_img
                    let id = i.product_id
                    let tempProduct = Product(name: name!, icon: image!, priceBeforeSale: priceBeforeSale!, finalPrice: finalPrice!, id: id!, brand: brand!)
                    tempProducts.append(tempProduct!)
                }
                self.productlist = tempProducts
                self.productListTV.reloadData()
                
                self.setNumOfProducts()
                print(self.productCount)
                print(item)
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
        else {
            category = packageNamesToSend[idx]
            GetPackageList.shared.getPackageList(category!, flag){
                [weak self]
                data in
                
                guard let `self` = self else { return }
                switch data {
                case .success(let res):
                    
                    let _res: ResponsePackage<Package> = res as! ResponsePackage<Package>
                    self.productCount = _res.package_count
                    let item : [Package] = _res.packages!
                    print(_res.packages!)
                    var tempProducts = [Product]()
                    for i in _res.packages! {
                        let name = i.name
                        print(name!)
                        let priceBeforeSale = i.price
                        let finalPrice = i.saled_price
                        let image = i.main_img
                        let id = i.package_id
                        let tempProduct = Product(name: name!, icon: image!, priceBeforeSale: priceBeforeSale!, finalPrice: finalPrice!, id: id!)
                        tempProducts.append(tempProduct!)
                    }
                    self.productlist = tempProducts
                    self.productListTV.reloadData()
                    
                    self.setNumOfProducts()
                    print(self.productCount)
                    print(item)
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
    
    func setNumOfProducts() {
        print("setNumofProductsCalled!")
            numOfProducts.text = "\(productCount)개의 상품"
    }
    
    func registerTVC() {
        let nibName1 = UINib(nibName: "PeriodicalCell", bundle: nil)
        productListTV.register(nibName1, forCellReuseIdentifier: "PeriodicalCell")
        let nibName2 = UINib(nibName: "PackageCell", bundle: nil)
        productListTV.register(nibName2, forCellReuseIdentifier: "PackageCell")
    }
    func reorderTable(label: String, flag : Int) {
        setOrderBtn.setTitle(label, for: .normal)
        self.flag = flag
        getItems(idx: idx!, flag: flag)
        setNumOfProducts()
        productListTV.reloadData()
    }
    /*func setTestItems() {
        if buttonselection == 0 {
        let name = "제주삼다수, 500ml,40개입"
        let brand = "삼다수"
        let pricebefore = 11700
        let price = 10000
        let image = "productImg"
        let product = Product(name: name, icon: image, priceBeforeSale: pricebefore, finalPrice: price, brand: brand)!
        for _ in 0 ..< 10 {
            periodialProducts.append(product)
        }
        }
        else {
        let name = "플레이팅 완벽하게 끝내기"
        let pricebefore = 11700
        let price = 10000
        let image = "packageImage"
        let product = Product(name: name, icon: image, priceBeforeSale: pricebefore, finalPrice: price)!
        for i in 0 ..< 10 {
            packageProducts.append(product)
            print(packageProducts[i])
            }
        }
 
    }
 */
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

    @IBAction func selectOrder(_ sender: Any) {
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "최신순", style: .default, handler: { result in self.reorderTable(label: "최신순 ", flag: 1)}))
        actionSheet.addAction(UIAlertAction(title: "인기순", style: .default, handler: { result in self.reorderTable(label: "인기순 ", flag: 2) }))
        actionSheet.addAction(UIAlertAction(title: "가격 낮은순", style: .default, handler: { result in self.reorderTable(label: "가격 낮은순 ", flag: 3) }))
        actionSheet.addAction(UIAlertAction(title: "가격 높은순", style: .default, handler: { result in self.reorderTable(label: "가격 높은순 ", flag: 4) }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
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
}

extension PeriodicalProductVC: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        idx = indexPath.row
        getItems(idx: idx!, flag: self.flag)
        productTypeCV.reloadData()
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
        if buttonselection == 0 {
        let dvc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        let height = self.view.frame.height
        dvc.viewHeight = height
        dvc.product_id = self.productlist[indexPath.row].id
        print(self.productlist[indexPath.row].id)
    navigationController?.pushViewController(dvc, animated: true)
    }
        else {
            //let height = self.view.frame.height
            
            let dvc = storyboard?.instantiateViewController(withIdentifier: "PackageDetailViewController") as! PackageDetailViewController
            //dvc.viewHeight = height
            print(self.productlist[indexPath.row].id)
            dvc.package_id = self.productlist[indexPath.row].id
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

extension PeriodicalProductVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return productlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(buttonselection!)
        if buttonselection == 0 {
        let cell = productListTV.dequeueReusableCell(withIdentifier: "PeriodicalCell", for: indexPath) as! PeriodicalCell
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedPriceBeforeSale = formatter.string(from: NSNumber(value:productlist[indexPath.row].priceBeforeSale!))
        let formattedFinalPrice = formatter.string(from: NSNumber(value:productlist[indexPath.row].finalPrice!))
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: formattedPriceBeforeSale!)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.productImg.imageFromUrl(productlist[indexPath.row].icon!)
        cell.productName.text = productlist[indexPath.row].name
        cell.productBrand.text = productlist[indexPath.row].brand
        cell.priceBeforeSale.attributedText = attributeString
        cell.finalPrice.text = formattedFinalPrice
        return cell
    }
        else {
            let cell = productListTV.dequeueReusableCell(withIdentifier: "PackageCell", for: indexPath) as! PackageCell
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formattedPriceBeforeSale = formatter.string(from: NSNumber(value:productlist[indexPath.row].priceBeforeSale!))
            let formattedFinalPrice = formatter.string(from: NSNumber(value:productlist[indexPath.row].finalPrice!))
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: formattedPriceBeforeSale!)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.productImg.imageFromUrl(productlist[indexPath.row].icon!)
            cell.productName.text = productlist[indexPath.row].name
            cell.priceBeforeSale.attributedText = attributeString
            cell.finalPrice.text = formattedFinalPrice
            return cell
            }
        }
}

