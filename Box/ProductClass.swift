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
    var priceBeforeSale: String?
    var finalPrice: String?
    
    
    init?(name: String, icon: String, brand: String, priceBeforeSale: String, finalPrice: String) {
        self.name = name
        self.icon = icon
        self.brand = brand
        self.priceBeforeSale = priceBeforeSale
        self.finalPrice = finalPrice
        
    }
}
