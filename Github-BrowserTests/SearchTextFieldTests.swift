//
//  SearchTextFieldTests.swift
//  Github-BrowserTests
//
//  Created by Hanzel, Szymon on 23/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import XCTest
@testable import Github_Browser

class SearchTextFieldTests: XCTestCase {

    let shSearchTextField    = SHSearchTextField()
    let mainSearchTextField  = SHMainSearchTextField()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSHSearchField() {
        shSearchTextField.text = nil
        var returnContent = shSearchTextField.returnContent()
        XCTAssertNil(returnContent)
        
        shSearchTextField.text = ""
        returnContent = shSearchTextField.returnContent()
        XCTAssertNil(returnContent)
        
        shSearchTextField.text = "test"
        returnContent = shSearchTextField.returnContent()
        XCTAssertNotNil(returnContent)
        XCTAssert(returnContent == "test")
    }
    
    func testMainSHSearchField() {
        mainSearchTextField.text = nil
        var returnContent = mainSearchTextField.returnContent()
        XCTAssertNotNil(returnContent)
        
        mainSearchTextField.text = ""
        returnContent = mainSearchTextField.returnContent()
        XCTAssert(returnContent == "")
        
        mainSearchTextField.text = "test"
        returnContent = mainSearchTextField.returnContent()
        XCTAssert(returnContent == "test")
        
    }

}
