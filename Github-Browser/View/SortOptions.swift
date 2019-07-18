//
//  SortOptions.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 15/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import Foundation

enum SortOptions: String, CaseIterable {
    case bestMatchDesc  = "Best match"
    case mostForks      = "Most Forks"
    case fewestForks    = "Fewest Forks"
    case mostStars      = "Most Stars"
    case fewestStars    = "Fewest Stars"
    case updatedDesc    = "Recently Updated"
    case updatedAsc     = "Least Recently Updated"
    
    static func allCases() -> [String] {
        var array: [String] = []
        for singlecase in SortOptions.allCases {
            array.append(singlecase.rawValue)
        }
        return array
    }
}
