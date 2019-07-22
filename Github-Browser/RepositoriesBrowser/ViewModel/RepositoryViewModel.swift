//
//  RepositoryEditorViewModel.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 15/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit


protocol RepositoryViewModel {
    var id: Int {get}
    var repositoryName: String {get}
    var userName: String {get}
    var starsCount: String {get}
    var forksCount: String {get}
    var userImageURL: String {get}
    var userImage: UIImage? {get}
    var language: String {get}
    var license:String {get}
    var htmlURL: String {get}
    var openIssues: String {get}
    var created: String {get}
    func downloadAvatar()
}


class RepositoryViewModelForTableView: NSObject, RepositoryViewModel {

    var id: Int
    
    var language: String
    
    var repositoryName: String
    
    var userName: String
    
    var starsCount: String
    
    var forksCount: String
    
    var userImageURL: String
    
    var userImage: UIImage?
    
     var htmlURL: String
    
    var openIssues: String
    
    var created: String
    
    var license: String
    
    init?(withRepository repositoryModel:Repository) {
        guard let rid   = repositoryModel.id else {return nil}
        id              = rid
        guard let rn    = repositoryModel.name else {return nil}
        repositoryName  = rn
        guard let owner = repositoryModel.owner, let login = owner.login else {return nil}
        userName        = login
        guard let sc    = repositoryModel.stargazersCount else {return nil}
        starsCount      = String(sc)
        guard let fc    = repositoryModel.forks else {return nil}
        forksCount      = String(fc)
        guard let uiu   = owner.avatarURL else {return nil}
        userImageURL    = uiu
        language        = repositoryModel.language ?? ""
        license         = repositoryModel.license?.name ?? ""
        guard let html  = repositoryModel.htmlURL else {return nil}
        htmlURL         = html
        guard let dateToFormat = repositoryModel.createdAt else {return nil}
        created         = "01-01-1970"
        if let openIssues = repositoryModel.openIssues{
            self.openIssues = String(openIssues)
        } else {
            self.openIssues = "0"
        }
        super.init()
        created         =  self.formatDate(date: dateToFormat)
        userImage = UIImage(named: "default_avatar") //default icon
    }
    
    fileprivate func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
    
    fileprivate func downloaded(from url: URL) {

        let data = try? Data(contentsOf: url)//make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        if let imageData = data, let downloadedImage = UIImage(data: imageData) {
            self.userImage = downloadedImage
        }
    }
    func downloadAvatar() {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: self.userImageURL) else { return }
        downloaded(from: url)
    }
    
}
