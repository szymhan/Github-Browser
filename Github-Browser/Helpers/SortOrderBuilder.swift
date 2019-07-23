//
//  SortOrderBuilder.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 16/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import Foundation

// Struct responsible for building sort & order part of endpoint (for example "&sort=best_match&order=desc")
struct SortOrderConstructor {
    private var options:NSArray?
    
    var selectedSortOrder:String
    
    
    init(selectedText:String) {
        self.selectedSortOrder = selectedText
        loadPlist()
    }
}

extension SortOrderConstructor {
   
    var sortedBy:String {
        guard options != nil else {
            return ""
        }
        return searchInDictionary(for: "sort")
       
    }
    
    var orderBy: String {
        guard options != nil else {
            return "desc"
        }
        return searchInDictionary(for: "order")
    }
    
    //
    //function returning ordered key value. Kind of if-ology here...
    //
    private func searchInDictionary(for key:String) -> String {
        for dictionary in options!{
            //if dictionary is of NSDictionary type and it has "name" key
            if let dict = dictionary as? NSDictionary, let name = dict["name"] as? String{
                //if it's the dictionary, that contains the selectedSortOrder name that we're looking for (passed when initialized)
                if name == selectedSortOrder {
                    // return the value of the key passed as an argument
                    if let sort = dict[key] as? String {
                        return sort
                    }
                }
            }
        }
        return "desc"
    }
    
    mutating private func loadPlist() {
        PlistManager.shared.getArrayFrom("SortOrder") { (result, err) in
            if err != nil {
                print("\(err.debugDescription) for SortOrder.plist")
                options = nil
                return
            }
            guard let array = result else {
                options = nil
                return
            }
            options = array
        }
    }
    
}
