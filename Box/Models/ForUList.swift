//
//  ForUList.swift
//  Box
//
//  Created by Jun Seub Lim on 12/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

import Foundation
struct ForUList: Codable {
    let packages: [ForUPackage]?
    let regularity: [ForUProduct]?
    let regular_not_Important: [ForUProduct]?
}
