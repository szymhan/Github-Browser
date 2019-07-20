//
//  RawServerResponse].swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 16/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.

import Foundation

// MARK: - RawServerResponse
struct RawServerResponse: Decodable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
