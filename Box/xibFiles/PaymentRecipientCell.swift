//
//  PaymentRecipientCell.swift
//  Box
//
//  Created by Jun Seub Lim on 11/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class PaymentRecipientCell: UITableViewCell {

    @IBOutlet var recipientTF: UITextField!
    @IBOutlet var phone1TF: UITextField!
    @IBOutlet var phone2TF: UITextField!
    @IBOutlet var phone3TF: UITextField!
    @IBOutlet var address1TF: UITextField!
    @IBOutlet var address2TF: UITextField!
    @IBOutlet var address3TF: UITextField!
    @IBOutlet var addressSearchBtn: UIButton!
    @IBOutlet var deliveryMemoBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        recipientTF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
           phone1TF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
           phone2TF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
           phone3TF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
           address1TF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
           address2TF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
           address3TF.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
           addressSearchBtn.setBorder(borderColor: UIColor.pumpkinOrange, borderWidth: 1)
           deliveryMemoBtn.setBorder(borderColor: UIColor.brownishGrey, borderWidth: 1)
        recipientTF.makeRounded(cornerRadius: 3)
        phone1TF.makeRounded(cornerRadius: 3)
        phone2TF.makeRounded(cornerRadius: 3)
        phone3TF.makeRounded(cornerRadius: 3)
        address1TF.makeRounded(cornerRadius: 3)
        address2TF.makeRounded(cornerRadius: 3)
        address3TF.makeRounded(cornerRadius: 3)
        addressSearchBtn.makeRounded(cornerRadius: 3)
        deliveryMemoBtn.makeRounded(cornerRadius: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
