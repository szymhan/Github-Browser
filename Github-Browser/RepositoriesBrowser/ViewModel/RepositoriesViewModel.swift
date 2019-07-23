//
//  RepositoriesEditorViewModel.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 15/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit

protocol RepositoriesViewModelProtocol {
    
    var totalCount:Int { get }
    
    var repositories: [RepositoryViewModel] { get }
    func sectionHeader() -> String
    func downloadAvatars()
}

class RepositoriesViewModel: NSObject,RepositoriesViewModelProtocol {
    
    var totalCount: Int
    
    var repositories: [RepositoryViewModel] = []
    
    var query: String?
    
    init?(response: RawServerResponse) {
        guard let tc    = response.totalCount else {return nil}
        self.totalCount = tc
        super.init()
        response.items.forEach { (repository) in
            guard let newRepoViewModel = RepositoryViewModelForTableView(withRepository: repository) else {return}
            repositories.append(newRepoViewModel)
        }
    }
    
    func downloadAvatars() {
        if repositories.count == 0 {return}
        for repository in repositories{
            repository.downloadAvatar()
        }
    }
    
    func sectionHeader() -> String {
        if query != ""{
            return "\(totalCount) results for \(query!)"
        }
        return "\(totalCount) results"
    }
}

