//
//  PackageDetail.swift
//  Box
//
//  Created by Jun Seub Lim on 10/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import Foundation

struct PackageDetail<T: Codable>: Codable {
    let package_id : String?
    let main_img : String?
    let name: String?
    let sale_ratio: Int?
    let price: Int?
    let saled_price: Int?
    let product: [T]?
}
