//
//  QueryBuilderTests.swift
//  Github-BrowserTests
//
//  Created by Hanzel, Szymon on 23/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import XCTest
@testable import Github_Browser

class QueryBuilderTests: XCTestCase {

    let mainTextField = SHMainSearchTextField()
    let userTextField = SHTextField()
    let languageTextField = SHSearchTextField()
    let readmeCheckBox = SHCheckBox()
    let nameCheckBox = SHCheckBox()
    let descriptionCheckBox = SHCheckBox()
    
    var dictionary: [String?: [QueryElementDelegate]] = [:]
    
    override func setUp() {
        dictionary = [nil: [mainTextField],
                      "language": [languageTextField],
                      "user" : [userTextField],
                      "in": [readmeCheckBox, nameCheckBox, descriptionCheckBox]
        ]}

    override func tearDown() {
        super.tearDown()
    }
    
    func testQueryBuildConstructing() {
        let queryConstructor = QueryConstructor(dictionary: dictionary)
        mainTextField.text       = "test"
        userTextField.text       = "user"
        languageTextField.text   = "swift"
        readmeCheckBox.name      = "readme"
        nameCheckBox.name        = "name"
        descriptionCheckBox.name = "description"
        readmeCheckBox.isChecked        = false
        nameCheckBox.isChecked          = true
        descriptionCheckBox.isChecked   = true
        
        let generatedMatching = queryConstructor.matching
        
        XCTAssert(generatedMatching.contains("user:user"), "QueryConstructor matching does not contain the user component")
        XCTAssert(generatedMatching.contains("test"), "QueryConstructor matching does not contain the main search")
        
        XCTAssert(generatedMatching.contains("language:swift"), "QueryConstructor matching does not contain the language component")
        
        XCTAssert(generatedMatching.contains("in:name"), "QueryConstructor matching does not contain the in:name component")
        
        XCTAssert(generatedMatching.contains("in:description"), "QueryConstructor matching does not contain the in:description component")
        
        XCTAssert(!generatedMatching.contains("in:readme"), "QueryConstructor matching contains the in:readme component")
        
        
    }

    

}
