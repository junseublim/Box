//
//  ViewController.swift
//  Box
//
//  Created by Jun Seub Lim on 30/06/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var skipBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var startBtn: UIButton!
    typealias Cart_RegularRecord = (String,String,String,Int,Int, Int)
    typealias Cart_PackageRecord = (String,String,String, Int,Int)
    let cart_RegularDAO = Cart_RegularDAO()
    let cart_PackageDAO = Cart_PackageDAO()
    let recentSearchDAO = RecentSearchedDAO()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize.width = self.view.frame.width * CGFloat(3)
        createviews()
        skipBtn.tintColor = UIColor.charcoalGrey
        nextBtn.tintColor = UIColor.pumpkinOrange
        startBtn.isHidden = true
        self.startBtn.makeRounded(cornerRadius: 5)
        startBtn.backgroundColor = UIColor.pumpkinOrange
        let RegularItems : [Cart_RegularRecord] = cart_RegularDAO.find()
        let PackageItems : [Cart_PackageRecord] = cart_PackageDAO.find()
        for regularitem in RegularItems {
            print("appendingRegularItem")
            print(regularitem)
            appDelegate.cart[0].append(CartItem(id: regularitem.0, name: regularitem.1, image: regularitem.2, price: regularitem.3, amount: regularitem.4, duration: regularitem.5)! )
        }
        for packageitem in PackageItems {
            print("appendingPackageItem")
            print(packageitem)
            appDelegate.cart[1].append(CartItem(id: packageitem.0,name: packageitem.1,image: packageitem.2, price: packageitem.3, amount: packageitem.4)!)
        }
        let searchedlist : [String] = recentSearchDAO.find()
        appDelegate.recentSearched = searchedlist.reversed()
    }
    
    @IBAction func startSlide(_ sender: Any) {
        let dvc = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
        
        self.present(dvc, animated: true, completion: nil)
    }
    @IBAction func skipSlide(_ sender: Any) {
        let dvc = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
        
        self.present(dvc, animated: true, completion: nil)
    }
    @IBAction func nextSlide(_ sender: Any) {
        if pageControl.currentPage < 2{
        let xOffset = scrollView.contentOffset.x
        let yOffset = scrollView.contentOffset.y
        let customOffset = CGPoint(x: xOffset + self.view.frame.width, y: yOffset)
        scrollView.setContentOffset(customOffset, animated: true)
        pageControl.currentPage = pageControl.currentPage + 1
        }
        if pageControl.currentPage == 2 {
            startBtn.isHidden = false
            nextBtn.isHidden = true
            skipBtn.isHidden = true
        }
    }
    func createviews() {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let view2 = UIView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let view3 = UIView(frame: CGRect(x: self.view.frame.width * CGFloat(2), y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.addSubview(view1)
        scrollView.addSubview(view2)
        scrollView.addSubview(view3)
        let imageview1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 301, height: 301))
        imageview1.image = UIImage(named: "onboardingImg1")
        imageview1.translatesAutoresizingMaskIntoConstraints = false
        view1.addSubview(imageview1)
        let imageview2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 301, height: 301))
        imageview2.image = UIImage(named: "onboardingImg2")
        imageview2.translatesAutoresizingMaskIntoConstraints = false
        view2.addSubview(imageview2)
        let imageview3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 301, height: 301))
        imageview3.image = UIImage(named: "onboardingImg3")
        imageview3.translatesAutoresizingMaskIntoConstraints = false
        view3.addSubview(imageview3)
        let ratio = 168/812 * self.view.frame.height
        imageview1.centerXAnchor.constraint(equalTo: view1.centerXAnchor).isActive = true
        let margins1 = view1.layoutMarginsGuide
        imageview1.topAnchor.constraint(equalTo: margins1.topAnchor, constant:  ratio).isActive = true
        imageview2.centerXAnchor.constraint(equalTo: view2.centerXAnchor).isActive = true
        let margins2 = view2.layoutMarginsGuide
        imageview2.topAnchor.constraint(equalTo: margins2.topAnchor, constant:  ratio).isActive = true
        imageview3.centerXAnchor.constraint(equalTo: view3.centerXAnchor).isActive = true
        let margins3 = view3.layoutMarginsGuide
        imageview3.topAnchor.constraint(equalTo: margins3.topAnchor, constant:  ratio).isActive = true
        //addLabel(view: view1, imgview: imageview1, idx: 1)
        //addLabel(view: view2, imgview: imageview2, idx: 2)
        //addLabel(view: view3, imgview: imageview3, idx: 3)
        pageControl.pageIndicatorTintColor = UIColor.lightBlueGrey
        pageControl.currentPageIndicatorTintColor = UIColor.pumpkinOrange
    }
    func addLabel(view: UIView, imgview: UIImageView, idx: Int){
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "NotoSans-SemiBold", size: 17)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        switch idx {
        case 1:
            view.addSubview(label)
            label.text = "어느새 다 떨어진 물, 세제, 휴지 등은 정기배송으로 해결하고"
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            label.topAnchor.constraint(equalTo: imgview.bottomAnchor, constant: 4).isActive = true
            label.widthAnchor.constraint(equalToConstant: 250).isActive = true
        case 2:
            view.addSubview(label)
            label.text = "자취 생활에 필요한 것 무엇인지 잘 모르겠다면 패키지로 시키자"
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            label.topAnchor.constraint(equalTo: imgview.bottomAnchor, constant: 4).isActive = true
            label.widthAnchor.constraint(equalToConstant: 220).isActive = true
        case 3:
            view.addSubview(label)
            label.text = "혼자 사는 너를 위해 준비해박스"
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            label.topAnchor.constraint(equalTo: imgview.bottomAnchor, constant: 4).isActive = true
           label.widthAnchor.constraint(equalToConstant: 160).isActive = true
            
            
            
        default:
            break
        }
        
    }
}

extension ViewController : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
        if Int(scrollView.contentOffset.x / scrollView.frame.maxX) == 2 {
            startBtn.isHidden = false
            nextBtn.isHidden = true
            skipBtn.isHidden = true
        }
        else {
            startBtn.isHidden = true
            nextBtn.isHidden = false
            skipBtn.isHidden = false
        }
    }
    
}
