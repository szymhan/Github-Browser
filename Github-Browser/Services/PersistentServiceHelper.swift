//
//  PersistentServiceHelper.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 23/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import CoreData


class PersistentServiceHelper {
    
    
    static func fetchSearches() -> [String]{
        let fetchRequest: NSFetchRequest<Search> = Search.fetchRequest()
        var searches: [String] = []
        
        do {
            let searchObjects = try PersistenceService.context.fetch(fetchRequest)
            let sort = NSSortDescriptor(key: #keyPath(Search.date), ascending: true)
            fetchRequest.sortDescriptors = [sort]
            searchObjects.forEach { (search) in
                if let searchedText = search.text, !searches.contains(searchedText) {
                    searches.append(searchedText)
                }
            }
            return searches
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
}

