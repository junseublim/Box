//
//  CartPeriodicalCell.swift
//  Box
//
//  Created by Jun Seub Lim on 05/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class CartPeriodicalCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var durationBtn: UIButton!
    @IBOutlet var countLabel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
