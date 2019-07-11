//
//  PaymentHeaderCell.swift
//  Box
//
//  Created by Jun Seub Lim on 11/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class PaymentHeaderCell: UITableViewCell {

    @IBOutlet var arrowImg: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    var headerNum = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
