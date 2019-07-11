//
//  productCell.swift
//  Box
//
//  Created by Jun Seub Lim on 03/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class productCell: UICollectionViewCell {
    //카테고리 8개
    @IBOutlet var productView: UIView!
    @IBOutlet var productTypeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
   productView.setBorder(borderColor: UIColor.lightBlueGrey, borderWidth: 0.5)
    }
}
