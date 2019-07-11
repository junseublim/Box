//
//  CartPeriodicalCell.swift
//  Box
//
//  Created by Jun Seub Lim on 05/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class CartPeriodicalCell: UITableViewCell {

    @IBOutlet var selectBtn: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var durationBtn: UIButton!
    @IBOutlet var countBtn: UIButton!
    weak var delegate : CartPeriodicalCellDelegate?
    var selectedBool = true
    var section: Int!
    var row: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.countBtn.addTarget(self, action: #selector(countTouched(_:)), for: .touchUpInside)
        durationBtn.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
    durationBtn.makeRounded(cornerRadius: 2)
       
        countBtn.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
        countBtn.makeRounded(cornerRadius: 2)
        selectBtn.makeRounded(cornerRadius: 1)
         selectBtn.setBorder(borderColor: UIColor.black, borderWidth: 1)
      //  changeImg(selected: selectedBool)
        print("loaded")
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   
    }
    @IBAction func deleteTouched(_ sender: Any) {
        if let section = section,
            let row = row {
            self.delegate?.CartPeriodicalCell(self, cancelTouchedFor1: section, cancelTouchedFor2: row)
        }
    }
    
    @IBAction func durationTouched(_ sender: Any) {
        if let section = section,
            let row = row {
            self.delegate?.CartPeriodicalCell(self, durationTouchedFor1: section, durationTouchedFor2: row)
        }
        
    }
    @IBAction func countTouched(_ sender: Any) {
        if let section = section,
            let row = row {
            self.delegate?.CartPeriodicalCell(self, countTouchedFor1: section, countTouchedFor2: row)
        }
        
    }
    
}

protocol CartPeriodicalCellDelegate: AnyObject {
    func CartPeriodicalCell(_ CartPeriodicalCell: CartPeriodicalCell, durationTouchedFor1 section: Int, durationTouchedFor2 row: Int)
    
    func CartPeriodicalCell(_ CartPeriodicalCell: CartPeriodicalCell, countTouchedFor1 section: Int, countTouchedFor2 row: Int)
    
     func CartPeriodicalCell(_ CartPeriodicalCell: CartPeriodicalCell, cancelTouchedFor1 section: Int, cancelTouchedFor2 row: Int)
}
