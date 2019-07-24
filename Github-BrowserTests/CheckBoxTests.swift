//
//  CheckBoxTests.swift
//  Github-BrowserTests
//
//  Created by Hanzel, Szymon on 23/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import XCTest
@testable import Github_Browser

class CheckBoxTests: XCTestCase {

    let checkBox = SHCheckBox(tag: "name", frame: .zero)

    override func setUp() {}

    override func tearDown() {
        super.tearDown()
    }


    func testCheckBox() {
        
        checkBox.isChecked = false
        var returnContent = checkBox.returnContent()
        XCTAssertNil(returnContent)
        
        checkBox.isChecked = true
        returnContent = checkBox.returnContent()
        XCTAssert(returnContent == "name")
    }

}
