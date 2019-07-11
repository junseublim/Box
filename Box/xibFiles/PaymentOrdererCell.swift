//
//  PaymentOrdererCell.swift
//  Box
//
//  Created by Jun Seub Lim on 11/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class PaymentOrdererCell: UITableViewCell {

    @IBOutlet var ordererLabel: UITextField!
    @IBOutlet var phone1TF: UITextField!
    @IBOutlet var phone2TF: UITextField!
    @IBOutlet var phone3TF: UITextField!
    @IBOutlet var emailTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        ordererLabel.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
         phone1TF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
         phone2TF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
         phone3TF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
         emailTF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
        ordererLabel.makeRounded(cornerRadius: 3)
        phone1TF.makeRounded(cornerRadius: 3)
        phone2TF.makeRounded(cornerRadius: 3)
        phone3TF.makeRounded(cornerRadius: 3)
        emailTF.makeRounded(cornerRadius: 3)
    }

}
