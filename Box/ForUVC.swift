//
//  ForUVC.swift
//  Box
//
//  Created by Jun Seub Lim on 02/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class ForUVC: UIViewController {

    @IBOutlet var durationPrepare: UIButton!
    @IBOutlet var durationOne: UIButton!
    @IBOutlet var durationOneToTwo: UIButton!
    @IBOutlet var durationTwo: UIButton!
    
    @IBOutlet var typeOneRoom: UIButton!
    @IBOutlet var typeMulti: UIButton!
    @IBOutlet var typeOpi: UIButton!
    @IBOutlet var typeApt: UIButton!
    @IBOutlet var sliderPrice: UISlider!
    @IBOutlet var rankTV: UITableView!
     @IBOutlet var setBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingBorders()
        
    }
   
    func settingBorders() {
        durationPrepare.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        durationOne.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        durationTwo.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        durationOneToTwo.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        typeApt.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        typeOpi.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        typeMulti.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
        typeOneRoom.setBorder(borderColor: UIColor.lightBlueGreyTwo, borderWidth: 1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
