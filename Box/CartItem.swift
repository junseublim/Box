//
//  CartItem.swift
//  Box
//
//  Created by Jun Seub Lim on 05/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import Foundation
import UIKit

class CartItem {
    var name: String?
    var icon: String?
    var finalPrice: String?
    var duration : Int?
    var count : Int?
    
    
    init?(name: String, icon: String, finalPrice: String,count: Int, duration: Int = 0 ) {
        self.name = name
        self.icon = icon
       self.finalPrice = finalPrice
        self.duration = duration
        self.count = count
        
    }
}
