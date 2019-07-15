//
//  SortOptions.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 15/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import Foundation

enum SortOptions: String, CaseIterable {
    case bestMatchDesc = "Best match desc"
    case bestMatchAsc = "Best match asc"
    case forksDesc = "Forks desc"
    case forksAsc = "Forks asc"
    case starsDesc = "Stars desc"
    case starsAsc = "Stars asc"
    case updatedDesc = "Updated desc"
    case updatedAsc = "Updated asc"
    
    static func allCases() -> [String] {
        var array: [String] = []
        for singlecase in SortOptions.allCases {
            array.append(singlecase.rawValue)
        }
        return array
    }
}
