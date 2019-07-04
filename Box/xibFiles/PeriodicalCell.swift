//
//  PeriodicalCell.swift
//  Box
//
//  Created by Jun Seub Lim on 03/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class PeriodicalCell: UITableViewCell {

    @IBOutlet var productImg: UIImageView!
    @IBOutlet var productBrand: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var priceBeforeSale: UILabel!
    @IBOutlet var finalPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
