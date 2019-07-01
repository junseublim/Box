//
//  HomeVC.swift
//  Box
//
//  Created by Jun Seub Lim on 01/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var cartBtn: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        scrollView.contentSize.width = self.view.frame.width * CGFloat(4)
        createviews()
        scrollView.delegate = self
        cartBtn.tintColor = UIColor.darkGrey
    }
    
    func createviews() {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let view2 = UIView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let view3 = UIView(frame: CGRect(x: self.view.frame.width * CGFloat(2), y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let view4 = UIView(frame: CGRect(x: self.view.frame.width * CGFloat(3), y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.addSubview(view1)
        scrollView.addSubview(view2)
        scrollView.addSubview(view3)
        scrollView.addSubview(view4)
        let imageratio = self.view.frame.width * 628/375
        let imageview1 = UIImageView()
        imageview1.image = UIImage(named: "71")
        imageview1.translatesAutoresizingMaskIntoConstraints = false
        view1.addSubview(imageview1)
        let imageview2 = UIImageView()
        imageview2.image = UIImage(named: "71")
        imageview2.translatesAutoresizingMaskIntoConstraints = false
        view2.addSubview(imageview2)
        let imageview3 = UIImageView()
        imageview3.image = UIImage(named: "71")
        imageview3.translatesAutoresizingMaskIntoConstraints = false
        view3.addSubview(imageview3)
        let imageview4 = UIImageView()
        imageview4.image = UIImage(named: "71")
        imageview4.translatesAutoresizingMaskIntoConstraints = false
        view4.addSubview(imageview4)
        imageview1.leadingAnchor.constraint(equalTo: view1.leadingAnchor).isActive = true
        imageview1.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
        imageview2.leadingAnchor.constraint(equalTo: view2.leadingAnchor).isActive = true
        imageview2.topAnchor.constraint(equalTo: view2.topAnchor).isActive = true
        imageview3.leadingAnchor.constraint(equalTo: view3.leadingAnchor).isActive = true
        imageview3.topAnchor.constraint(equalTo: view3.topAnchor).isActive = true
        
    imageview4.leadingAnchor.constraint(equalTo: view4.leadingAnchor).isActive = true
        imageview4.topAnchor.constraint(equalTo: view4.topAnchor).isActive = true
        imageview1.widthAnchor.constraint(equalToConstant: view1.frame.width).isActive = true
        imageview1.heightAnchor.constraint(equalToConstant: imageratio).isActive = true
        imageview2.widthAnchor.constraint(equalToConstant: view2.frame.width).isActive = true
        imageview2.heightAnchor.constraint(equalToConstant: imageratio).isActive = true
        imageview3.widthAnchor.constraint(equalToConstant: view3.frame.width).isActive = true
        imageview3.heightAnchor.constraint(equalToConstant: imageratio).isActive = true
        imageview4.widthAnchor.constraint(equalToConstant: view4.frame.width).isActive = true
        imageview4.heightAnchor.constraint(equalToConstant: imageratio).isActive = true
        addLabel(view: view1)
        addLabel(view: view2)
        addLabel(view: view3)

        addLabel(view: view4)

        
        //pageControl.pageIndicatorTintColor = UIColor.lightBlueGrey
        //pageControl.currentPageIndicatorTintColor = UIColor.pumpkinOrange
    }
    func addLabel(view: UIView){
        let label1 = UILabel()
        label1.text = "나만의 홈카페 즐기기"
        label1.numberOfLines = 1
        label1.font = UIFont(name: "NotoSans-SemiBold", size: 25)
        view.addSubview(label1)
        label1.textAlignment = NSTextAlignment.left
    label1.translatesAutoresizingMaskIntoConstraints = false
        label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label1.topAnchor.constraint(equalTo: view.topAnchor, constant: 609).isActive = true
        label1.heightAnchor.constraint(equalToConstant: 35).isActive = true
        let label2 = UILabel()
        label2.text = "홈카페 준비물 여기 다 있어요!"
        label2.numberOfLines = 1
        label2.font = UIFont(name: "NotoSans-SemiBold", size: 20)
        view.addSubview(label2)
        label2.textAlignment = NSTextAlignment.left
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 1).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        
    }
}

extension HomeVC: UIScrollViewDelegate{
    
    /*func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
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
    */
}

