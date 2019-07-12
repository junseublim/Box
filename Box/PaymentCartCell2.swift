//
//  PaymentCartCell2.swift
//  
//
//  Created by Jun Seub Lim on 12/07/2019.
//

import UIKit

class PaymentCartCell2: UITableViewCell {
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productName: UILabel!
    
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
