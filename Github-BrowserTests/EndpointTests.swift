//
//  EndpointTests.swift
//  Github-BrowserTests
//
//  Created by Hanzel, Szymon on 23/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import XCTest

@testable import Github_Browser
class EndpointTests: XCTestCase {

    var endPoint = Endpoint.search(matching: "test", sortedBy: "stars", orderBy: "desc", page: 0)
    let validURL = URL(string: "https://api.github.com/search/repositories?q=test&sort=stars&order=desc&page=0")
     let validChangePageURL = URL(string: "https://api.github.com/search/repositories?q=test&sort=stars&order=desc&page=2")
    
    override func setUp() {}

    override func tearDown() {
        super.tearDown()
    }

    func testEndpointURLBuilding() {
        
        let endpointURL = endPoint.url
        
        XCTAssertNotNil(endpointURL)
        
        XCTAssert(validURL == endpointURL)
    }
    
    func testEndPointChangePage() {
        endPoint.changePage(page: 2)
        
        let endPointURL = endPoint.url
        
        XCTAssertNotNil(endPointURL)
        XCTAssert(endPointURL == validChangePageURL)
        
    }
    


}
