//
//  Package.swift
//  Box
//
//  Created by Jun Seub Lim on 09/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import Foundation

struct Package: Codable {
    let package_id: String?
    let name: String?
    let main_img: String?
    let price: Int?
    let saled_price: Int?
}
