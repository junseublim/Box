//
//  ProductClass.swift
//  Box
//
//  Created by Jun Seub Lim on 03/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import Foundation
import UIKit

class Product {
    var name: String?
    var brand: String?
    var icon: String?
    var priceBeforeSale: Int?
    var finalPrice: Int?
    var id: String?

    
    init?(name: String, icon: String,  priceBeforeSale: Int, finalPrice: Int,id: String, brand: String = "") {
        self.name = name
        self.icon = icon
        self.brand = brand
        self.priceBeforeSale = priceBeforeSale
        self.finalPrice = finalPrice
        self.id = id
        
    }
}
