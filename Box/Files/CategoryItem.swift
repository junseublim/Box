//
//  CategoryItem.swift
//  Box
//
//  Created by Jun Seub Lim on 02/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import Foundation

class CategoryItem {

    var name: String?
    var icon: String?
    
    init?(name: String, icon: String) {
        self.name = name
        self.icon = icon
        
    }
}
