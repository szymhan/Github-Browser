//
//  License.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 19/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import Foundation

struct License: Codable {
    let key, name, spdxID: String?
    let url: String?
    let nodeID: String?
    
    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}
