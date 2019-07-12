//
//  SearchResultVC.swift
//  Box
//
//  Created by Jun Seub Lim on 12/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class SearchResultVC: UIViewController {

    @IBOutlet var searchResultTV: UITableView!
    @IBOutlet var orderBtn: UIButton!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var Searched: String?
    var productCount = 0
    var flag = 1
    var productList = [Product]()
    let recentSearchDAO = RecentSearchedDAO()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBtn(color: UIColor.brownishGrey)
        searchResultTV.delegate = self
        searchResultTV.dataSource = self
        searchBar.delegate = self
        registerTVC()
        searchBar.text = Searched
        self.navigationItem.title = "검색 결과"
        getItems(flag: 1)
    }
    
    func getItems(flag: Int) {
        GetSearchList.shared.getSearchList(Searched!, flag) {
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
                self.productList = tempProducts
                self.searchResultTV.reloadData()
                
                self.setNumOfProducts()
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
    
    func setNumOfProducts() {
         amountLabel.text = "\(productCount)개의 상품"
    }
    func registerTVC() {
        let nibName1 = UINib(nibName: "PeriodicalCell", bundle: nil)
        searchResultTV.register(nibName1, forCellReuseIdentifier: "PeriodicalCell")
        
    }
    func reorderTable(label: String, flag : Int) {
        orderBtn.setTitle(label, for: .normal)
        self.flag = flag
        getItems(flag: self.flag)
        searchResultTV.reloadData()
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
    @IBAction func reOrder(_ sender: Any) {
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
extension SearchResultVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let dvc = UIStoryboard(name: "ProductList", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
            let height = self.view.frame.height
            dvc.viewHeight = height
            dvc.product_id = self.productList[indexPath.row].id
            navigationController?.pushViewController(dvc, animated: true)
    }
}

extension SearchResultVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = searchResultTV.dequeueReusableCell(withIdentifier: "PeriodicalCell", for: indexPath) as! PeriodicalCell
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let formattedPriceBeforeSale = formatter.string(from: NSNumber(value:productList[indexPath.row].priceBeforeSale!))
            let formattedFinalPrice = formatter.string(from: NSNumber(value:productList[indexPath.row].finalPrice!))
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: formattedPriceBeforeSale!)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.productImg.imageFromUrl(productList[indexPath.row].icon!)
            cell.productName.text = productList[indexPath.row].name
            cell.productBrand.text = productList[indexPath.row].brand
            cell.priceBeforeSale.attributedText = attributeString
            cell.finalPrice.text = formattedFinalPrice
            return cell
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
        self.searchResultTV.removeGestureRecognizer(sender!)
    }
}
extension SearchResultVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.Searched = searchBar.text
        if Searched == "" {
            return
        }
        let rs = recentSearchDAO.create(searched: Searched!)
        if rs == true {
            appDelegate.recentSearched.insert(Searched!, at: 0)
            getItems(flag: flag)
            searchResultTV.reloadData()
            self.view.endEditing(true)
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.searchResultTV.addGestureRecognizer(tapGesture)
    }
}
