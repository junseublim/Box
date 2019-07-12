//
//  CategoryMenuVC.swift
//  Box
//
//  Created by Jun Seub Lim on 01/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit
class CategoryMenuVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let periodicImages = ["categoryDeliveryImg1","categoryDeliveryImg2","categoryDeliveryImg3","categoryDeliveryImg4","categoryDeliveryImg5","categoryDeliveryImg6","categoryDeliveryImg7","categoryDeliveryImg8"]
    let packageImages = ["categoryPackImg2","categoryPackImg6","categoryPackImg3","categoryPackImg4","categoryPackImg5", "categoryPackImg1", "categoryPackImg7", "categoryPackImg8"]
    let periodicNames = ["생수/음료", "세제/섬유유연제", "욕실용품","휴지/물티슈", "청소용품", "주방용품","디퓨저/방향제", "반려동물용품"]
    let packageNames = [ "공간확보의 달인","가전제품", "우리 집 관리", "홈카페", "포근하게 자기","입는건 중요해",  "반려동물과 함께", "특별기획"]
    @IBOutlet var categoryCollection: UICollectionView!
    @IBOutlet var periodicBtn: UIButton!
    @IBOutlet var packageBtn: UIButton!
    @IBOutlet var periodicView: UIView!
    @IBOutlet var packageView: UIView!
    var periodicDelivery = [CategoryItem]()
    var packageDelivery = [CategoryItem]()
    var buttonselection : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCVC()
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        periodicView.backgroundColor = UIColor.pumpkinOrange
        packageView.backgroundColor = UIColor.lightBlueGrey
        periodicBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
        packageBtn.setTitleColor(UIColor.darkGrey, for: .normal)
        setItemList()
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleLeftSwipe(_:)))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleRightSwipe(_:)))
        swipeRightGesture.direction = .right
        categoryCollection.addGestureRecognizer(swipeLeftGesture)
        categoryCollection.addGestureRecognizer(swipeRightGesture)
    }
    @objc func handleLeftSwipe(_ sender: UITapGestureRecognizer? = nil) {
        if buttonselection == 0 {
            self.packageTouched(nil)
        }
    }
    @objc func handleRightSwipe(_ sender: UITapGestureRecognizer? = nil) {
        if buttonselection == 1 {
             self.periodicTouched(nil)
        }
    }

    
    @IBAction func packageTouched(_ sender: AnyObject?) {
        packageView.backgroundColor = UIColor.pumpkinOrange
        periodicView.backgroundColor = UIColor.lightBlueGrey
packageBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
        periodicBtn.setTitleColor(UIColor.darkGrey, for: .normal)
        buttonselection = 1
        categoryCollection.reloadData()
    }
    @IBAction func periodicTouched(_ sender: AnyObject?) {
        periodicView.backgroundColor = UIColor.pumpkinOrange
        packageView.backgroundColor = UIColor.lightBlueGrey
        packageBtn.setTitleColor(UIColor.darkGrey, for: .normal)
        periodicBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
        buttonselection = 0
        categoryCollection.reloadData()
    }
    
    @IBAction func cart(_ sender: Any) {
        var dvc : UIViewController?
        if appDelegate.cart[0].isEmpty && appDelegate.cart[1].isEmpty == true {
            dvc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "EmptyVC")
        }
        else {
        dvc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "Cart2VC")
        }
        navigationController?.pushViewController(dvc!, animated: true)
    }
    func setItemList() {
        for i in 0 ..< 8 {
            let item1 = CategoryItem(name: periodicNames[i], icon: periodicImages[i])
            periodicDelivery.append(item1!)
            let item2 = CategoryItem(name: packageNames[i], icon: packageImages[i])
            packageDelivery.append(item2!)
        }
    }
    func registerCVC() {
        let nibName = UINib(nibName: "CategoryCVC", bundle: nil)
        categoryCollection.register(nibName, forCellWithReuseIdentifier: "CategoryCVC")
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return periodicImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as! CategoryCVC
        if buttonselection == 0 {
            cell.categoryImg.image = UIImage(named: periodicDelivery[indexPath.row].icon!)
        cell.categoryName.text = periodicDelivery[indexPath.row].name
        }
        else if buttonselection == 1 {
            cell.categoryImg.image = UIImage(named: packageDelivery[indexPath.row].icon!)
            cell.categoryName.text = packageDelivery[indexPath.row].name
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (categoryCollection.frame.width) / 4
        let height: CGFloat = categoryCollection.frame.height / 2
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dvc = UIStoryboard(name: "ProductList", bundle: nil).instantiateViewController(withIdentifier: "PeriodicalProductVC") as! PeriodicalProductVC
        if buttonselection == 0 {
            dvc.productTypeList = self.periodicNames
            dvc.naviTitle = "정기배송"}
        else if buttonselection == 1 {
            dvc.productTypeList = self.packageNames
            dvc.naviTitle = "패키지"
        }
        dvc.idx = indexPath.row
        dvc.buttonselection = self.buttonselection
        navigationController?.pushViewController(dvc, animated: true)
    }
}

