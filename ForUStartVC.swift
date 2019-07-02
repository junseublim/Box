//
//  ForUStartVC.swift
//  Box
//
//  Created by Jun Seub Lim on 02/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class ForUStartVC: UIViewController {

    @IBOutlet var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startBtn.makeRounded(cornerRadius: 5)
        startBtn.backgroundColor = UIColor.pumpkinOrange
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
