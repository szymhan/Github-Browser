//
//  QueryBuilder.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 16/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//



import Foundation


class QueryConstructorBuilder{
    var attributes = [String?:[QueryElementDelegate]]()
    
    init(){}
    @discardableResult
    func appendText(_ element:QueryElementDelegate) -> QueryConstructorBuilder {
        attributes[nil] = [element]
        return self
    }
    
    @discardableResult
    func appendUser(_ element:QueryElementDelegate) -> QueryConstructorBuilder {
        attributes["user"] = [element]
        return self
    }
    
    @discardableResult
    func appendLanguage(_ element:QueryElementDelegate) -> QueryConstructorBuilder {
        attributes["language"] = [element]
        return self
    }
    @discardableResult
    func appendIn(_ elements:[QueryElementDelegate]) -> QueryConstructorBuilder {
        attributes["in"] = elements
        return self
    }
    
    func build() -> QueryConstructor {
        return QueryConstructor(dictionary: attributes)
    }
}

struct QueryConstructor {
    var dictionary:[String?:[QueryElementDelegate]]

}

extension QueryConstructor {
    //
    //function returning
    //
    var matching:String {
        var matchingString = ""
        for (key,value) in dictionary {
            value.forEach { (element) in
                if let key = key, let elementContent = element.returnContent() {
                    matchingString.append("\(key):\(elementContent)+")
                } else if let elementContent = element.returnContent() {
                    matchingString.append("\(elementContent)+")
                }
               //matchingString.append("+")
            }
           // matchingString.append("+")
        }
        return matchingString
    }
}

//
//    static let emptyString = ""
//
//    func build(_ text: String, authorName: String, language: String, searchIn: String, completion: (String?, QueryBuildingError) -> (Void)) {
//        var queryString:String = ""
//        if text != .emptyString{
//            queryString.append(text)
//        }
//
//        if queryString == .emptyString {
//            completion(nil,.emptyFields)
//        }
//    }
