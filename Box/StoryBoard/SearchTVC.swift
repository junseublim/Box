//
//  SearchTVC.swift
//  Box
//
//  Created by Jun Seub Lim on 02/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import UIKit

class SearchTVC: UITableViewCell {

    @IBOutlet var searchItemName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func recentSearchDelete(_ sender: Any) {
        print("touched")
        }
    
}
