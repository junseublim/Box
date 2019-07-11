//
//  PaymentCell.swift
//  Box
//
//  Created by Jun Seub Lim on 11/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell {

    @IBOutlet var registerCardBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCardBtn.setBorder(borderColor: UIColor.pumpkinOrange, borderWidth: 1)
        registerCardBtn.makeRounded(cornerRadius: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
