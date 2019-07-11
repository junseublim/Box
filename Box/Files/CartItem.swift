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
    var id: String?
    var name: String?
    var image: String?
    var price: Int?
    var duration : Int?
    var amount : Int?
    var selected: Bool?
    
    
    init?(id: String, name: String, image: String, price: Int, amount: Int, duration: Int = 0, selected: Bool = true ) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.amount = amount
        self.duration = duration
        self.selected = true
    }
}
