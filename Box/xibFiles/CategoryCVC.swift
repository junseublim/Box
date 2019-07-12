//
//  CategoryCVC.swift
//  Box
//
//  Created by Jun Seub Lim on 01/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit
import Hero

class CategoryCVC: UICollectionViewCell {

    @IBOutlet var categoryImg: UIImageView!
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var categoryView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryView.setBorder(borderColor: UIColor.lightBlueGrey, borderWidth: 0.5)
        categoryName.hero.id = "category"
    }

}
