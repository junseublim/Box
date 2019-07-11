//
//  ResponsePackage.swift
//  Box
//
//  Created by Jun Seub Lim on 09/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import Foundation
struct ResponsePackage<T: Codable>: Codable {
    let package_count: Int
    let packages: [T]?
    
    
}
