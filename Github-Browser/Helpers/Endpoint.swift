//
//  Extension.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 17/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import Foundation

struct Endpoint {
    let path: String
    var queryItems: [URLQueryItem]
}

extension Endpoint {
    static func search(matching query: String,
                       sortedBy sorting: String,
                       orderBy ordering: String,
                       page: Int) -> Endpoint {
        return Endpoint(
            path: "/search/repositories",
            queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "sort", value: sorting),
                URLQueryItem(name: "order", value: ordering),
                URLQueryItem(name: "page", value: String(page))
            ]
        )
    }
}

extension Endpoint {
    // We still have to keep 'url' as an optional, since we're
    // dealing with dynamic components that could be invalid.
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
    
    mutating func setPage(page: Int) {
        var queryItems = self.queryItems
        //filtering out page queryItem
        queryItems = queryItems.filter({!$0.name.hasPrefix("page")})
        //adding new value
        queryItems.append(URLQueryItem(name: "page", value: String(page)))
        self.queryItems = queryItems
    }

}
