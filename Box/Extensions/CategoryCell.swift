//
//  CategoryCellCollectionViewCell.swift
//  Box
//
//  Created by Jun Seub Lim on 01/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet var CategoryView: UIView!
    @IBOutlet var CategoryImg: UIImageView!
    @IBOutlet var CategoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        CategoryView.setBorder(borderColor: UIColor.lightBlueGrey, borderWidth: 0.5)
        CategoryName.sizeToFit()
    }

}
