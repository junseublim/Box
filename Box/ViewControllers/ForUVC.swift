//
//  ForUVC.swift
//  Box
//
//  Created by Jun Seub Lim on 02/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit
import RangeSeekSlider

class ForUVC: UIViewController {
    var rankings = ["청소", "요리", "수면", "인테리어", "옷 관리"]
    var rankingsreset = ["청소", "요리", "수면", "인테리어", "옷 관리"]
    @IBOutlet var durationPrepare: UIButton!
    @IBOutlet var durationOne: UIButton!
    @IBOutlet var durationOneToTwo: UIButton!
    @IBOutlet var durationTwo: UIButton!
    
    @IBOutlet var typeOneRoom: UIButton!
    @IBOutlet var typeMulti: UIButton!
    @IBOutlet var typeOpi: UIButton!
    @IBOutlet var typeApt: UIButton!
    @IBOutlet var resetBtn: UIBarButtonItem!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var priceRanger: RangeSeekSlider!
    @IBOutlet var rankTV: UITableView!
     @IBOutlet var setBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingBorders()
        self.priceRanger.delegate = self
        self.rankTV.delegate = self
        self.rankTV.dataSource = self
        self.rankTV.isEditing = true
        selected(button: typeOneRoom, selected: true)
        selected(button: typeMulti, selected: false)
        selected(button: typeOpi, selected: false)
        selected(button: typeApt, selected: false)
        selected(button: durationPrepare, selected: true)
        selected(button: durationOne, selected: false)
        selected(button: durationOneToTwo, selected: false)
        selected(button: durationTwo, selected: false)
        
    }
   
    func settingBorders() {
       rankTV.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 0.5)
        durationPrepare.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        durationPrepare.makeRounded(cornerRadius: 3)
        durationOne.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        durationOne.makeRounded(cornerRadius: 3)
        durationTwo.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        durationOneToTwo.makeRounded(cornerRadius: 3)
        durationOneToTwo.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        durationTwo.makeRounded(cornerRadius: 3)
        typeApt.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        typeApt.makeRounded(cornerRadius: 3)
        typeOpi.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        typeOpi.makeRounded(cornerRadius: 3)
        typeMulti.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        typeMulti.makeRounded(cornerRadius: 3)
        typeOneRoom.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        typeOneRoom.makeRounded(cornerRadius: 3)
        setBtn.makeRounded(cornerRadius: 5)
    }
    func selected(button: UIButton, selected: Bool) {
        if selected == true {
            button.setBorder(borderColor: UIColor.pumpkinOrange, borderWidth: 1)
            button.setTitleColor(UIColor.pumpkinOrange, for: .normal)
        }
        else {
            button.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
            button.setTitleColor(UIColor.black, for: .normal)
        }
    }

    @IBAction func sendSetting(_ sender: Any) {
        print(priceRanger.selectedMinValue)
        print(priceRanger.selectedMaxValue)
        print(rankings)
    }
    
    @IBAction func resetAll(_ sender: Any) {
        
      //  priceRanger.selectedMaxValue = priceRanger.maxValue
      //  priceRanger.selectedMinValue = priceRanger.minValue
      //  priceRanger.reloadInputViews()
       self.viewDidLoad()
        rankings = rankingsreset
        rankTV.reloadData()

    }
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func selectType(_ sender: UIButton) {
        switch sender.currentTitle {
        case "원룸":
            selected(button: typeOneRoom, selected: true)
            selected(button: typeMulti, selected: false)
            selected(button: typeOpi, selected: false)
            selected(button: typeApt, selected: false)
        case "다인실 (투룸,쓰리룸)":
            selected(button: typeOneRoom, selected: false)
            selected(button: typeMulti, selected: true)
            selected(button: typeOpi, selected: false)
            selected(button: typeApt, selected: false)
        case "오피스텔":
            selected(button: typeOneRoom, selected: false)
            selected(button: typeMulti, selected: false)
            selected(button: typeOpi, selected: true)
            selected(button: typeApt, selected: false)
        case "아파트,주택":
            selected(button: typeOneRoom, selected: false)
            selected(button: typeMulti, selected: false)
            selected(button: typeOpi, selected: false)
            selected(button: typeApt, selected: true)
        default:
            break
        }
    }
    
    @IBAction func selectDuration(_ sender: UIButton) {
        
        switch sender.currentTitle {
        case "준비 중이야":
            selected(button: durationPrepare, selected: true)
            selected(button: durationOne, selected: false)
            selected(button: durationOneToTwo, selected: false)
            selected(button: durationTwo, selected: false)
        case "1년 미만":
            selected(button: durationPrepare, selected: false)
            selected(button: durationOne, selected: true)
            selected(button: durationOneToTwo, selected: false)
            selected(button: durationTwo, selected: false)
        case "1년 이상~2년 미만":
            selected(button: durationPrepare, selected: false)
            selected(button: durationOne, selected: false)
            selected(button: durationOneToTwo, selected: true)
            selected(button: durationTwo, selected: false)
        case "2년 이상":
            selected(button: durationPrepare, selected: false)
            selected(button: durationOne, selected: false)
            selected(button: durationOneToTwo, selected: false)
            selected(button: durationTwo, selected: true)
        default:
            break
        }
    }
    
}
extension ForUVC: RangeSeekSliderDelegate{
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat)
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let min = formatter.string(from: minValue as NSNumber)!
         let max = formatter.string(from: maxValue as NSNumber)!
        priceLabel.text = "\(min)원 ~ \(max)원"
    }
    
}
extension ForUVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = rankings[(sourceIndexPath as NSIndexPath).row]
        rankings.remove(at: (sourceIndexPath as NSIndexPath).row)
        rankings.insert(itemToMove, at: (destinationIndexPath as NSIndexPath).row)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rankTV.frame.height / 5
    }

}
extension ForUVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rankTV.dequeueReusableCell(withIdentifier: "ForUCell", for: indexPath)

        cell.textLabel!.text = rankings[indexPath.row]
                cell.textLabel!.font = UIFont(name: "NotoSans-SemiBold", size: 15)
        return cell
    }
}
