//
//  CategoryMenuVC.swift
//  Box
//
//  Created by Jun Seub Lim on 01/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class CategoryMenuVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    let periodicImages = ["categoryDeliveryImg1","categoryDeliveryImg2","categoryDeliveryImg3","categoryDeliveryImg4","categoryDeliveryImg5","categoryDeliveryImg6","categoryDeliveryImg7","categoryDeliveryImg8"]
    let packageImages = ["categoryPackImg1","categoryPackImg2","categoryPackImg3","categoryPackImg4","categoryPackImg5", "categoryPackImg6", "categoryPackImg7", "categoryPackImg8"]
    let periodicNames = ["생수/음료", "세제/섬유유연제", "욕실용품","휴지/물티슈", "청소용품", "주방용품","디퓨저/방향제", "디퓨저/방향제"]
    let packageNames = ["입는건 중요해", "공간확보의 달인", "우리 집 관리", "홈카페", "포근하게 자기", "가전제품", "반려동물과 함께", "특별기획"]
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
        packageView.backgroundColor = UIColor.darkGrey
        periodicBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
        packageBtn.setTitleColor(UIColor.darkGrey, for: .normal)
        setItemList()
    }

    
    @IBAction func packageTouched(_ sender: Any) {
        packageView.backgroundColor = UIColor.pumpkinOrange
        periodicView.backgroundColor = UIColor.darkGrey
packageBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
        periodicBtn.setTitleColor(UIColor.darkGrey, for: .normal)
        buttonselection = 1
        categoryCollection.reloadData()
    }
    @IBAction func periodicTouched(_ sender: Any) {
        periodicView.backgroundColor = UIColor.pumpkinOrange
        packageView.backgroundColor = UIColor.darkGrey
        packageBtn.setTitleColor(UIColor.darkGrey, for: .normal)
        periodicBtn.setTitleColor(UIColor.pumpkinOrange, for: .normal)
        buttonselection = 0
        categoryCollection.reloadData()
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
}
