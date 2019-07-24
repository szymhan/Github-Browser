//
//  SortOrderBuilderTests.swift
//  Github-BrowserTests
//
//  Created by Hanzel, Szymon on 23/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import XCTest
@testable import Github_Browser

class SortOrderBuilderTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {
        super.tearDown()
    }
    
    func fewestStarsSortOrder() {
        let builder = SortOrderBuilder(selectedText: "Fewest Stars")
        let order = builder.orderBy
        let sort  = builder.sortedBy
        
        XCTAssert(order == "asc")
        XCTAssert(sort == "stars")
    }
    
    func mostStarsSortOrder() {
        let builder = SortOrderBuilder(selectedText: "Most Stars")
        let order = builder.orderBy
        let sort  = builder.sortedBy
        
        XCTAssert(order == "desc")
        XCTAssert(sort == "stars")
    }

    func fewestForksSortOrder() {
        let builder = SortOrderBuilder(selectedText: "Fewest Forks")
        let order = builder.orderBy
        let sort  = builder.sortedBy
        
        XCTAssert(order == "asc")
        XCTAssert(sort == "forks")
    }
    
    func mostForksSortOrder() {
        let builder = SortOrderBuilder(selectedText: "Most Forks")
        let order = builder.orderBy
        let sort  = builder.sortedBy
        
        XCTAssert(order == "desc")
        XCTAssert(sort == "forks")
    }
    
    func bestMatchSortOrder() {
        let builder = SortOrderBuilder(selectedText: "Best Match")
        let order = builder.orderBy
        let sort  = builder.sortedBy
        
        XCTAssert(order == "desc")
        XCTAssert(sort == "")
    }
    
    func leastRecentlyUpdatedSortOrder() {
        let builder = SortOrderBuilder(selectedText: "Least Recently Updated")
        let order = builder.orderBy
        let sort  = builder.sortedBy
        
        XCTAssert(order == "asc")
        XCTAssert(sort == "updated")
    }
    
    func recentlyUpdatedSortOrder() {
        let builder = SortOrderBuilder(selectedText: "Recently Updated")
        let order = builder.orderBy
        let sort  = builder.sortedBy
        
        XCTAssert(order == "desc")
        XCTAssert(sort == "updated")
    }
}
