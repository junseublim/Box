//
//  PackageItemInsideCell.swift
//  Box
//
//  Created by Jun Seub Lim on 09/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class PackageItemInsideCell: UICollectionViewCell {

    @IBOutlet var backgroungView: UIView!
    @IBOutlet var packageItemImage: UIImageView!
    @IBOutlet var packageItemName: UILabel!
    @IBOutlet var packageItemPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroungView.setBorder(borderColor: UIColor.lightBlueGrey, borderWidth: 1)
    }

}
