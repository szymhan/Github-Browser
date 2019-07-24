//
//  SingleRepositoryView.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 21/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit

class SingleRepositoryView: UIView {

    let author      = SHLabel(text: "", size: 14, textAlign: .left, font: .helveticaRegular)
    let readmeLabel = SHLabel(text: "README.MD", size: 24, textAlign: .left, font: .helveticaBold)

    let html        = PropertyRowView(labelName: "Address :")
    let language    = PropertyRowView(labelName: "Language :")
    let stars       = PropertyRowView(labelName: "stars :")
    let forks       = PropertyRowView(labelName: "forks :")
    let created     = PropertyRowView(labelName: "Created :")
    let openIssues  = PropertyRowView(labelName: "Open Issues :")
    
    let readme:UITextView = {
       let readme = UITextView()
        readme.translatesAutoresizingMaskIntoConstraints = false
        readme.isEditable = false
        readme.layer.cornerRadius = 7
        readme.layer.borderColor = UIColor.grayOne.cgColor
        readme.layer.borderWidth = 1
        return readme
    }()
    
    let avatar: UIImageView = {
        let oi = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        oi.contentMode = .scaleAspectFit
        return oi
    }()
    
    let copyToClipboard:UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("Copy URL to Clipboard", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10.0
        button.contentHorizontalAlignment = .center
        button.layer.borderColor = UIColor.iphoneBlue.cgColor
        button.layer.borderWidth = 1.0
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        return button
    }()
    
    
    var viewModel: RepositoryViewModel? {
        didSet {
            fillUI()
        }
    }
    
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(avatar)
        self.addSubview(author)
        self.addSubview(copyToClipboard)
        
        self.addSubview(html)
        self.addSubview(language)
        self.addSubview(stars)
        self.addSubview(forks)
        self.addSubview(openIssues)
        self.addSubview(created)
        
        self.addSubview(readmeLabel)
        self.addSubview(readme)
        setUI()
    }
    
    func setUI() {
        let width = screenWidth()
        
        
        avatar.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        author.snp.makeConstraints { (make) in
            make.top.equalTo(avatar.snp_bottom).offset(5)
            make.centerX.width.equalTo(avatar)
        }
        
        copyToClipboard.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(width * 0.15)
            make.centerY.equalTo(avatar)
            make.width.equalTo(width * 0.3)
            make.height.equalTo(avatar.snp_height).multipliedBy(0.3)
        }
        
        html.snp.makeConstraints { (make) in
            make.top.equalTo(author.snp_bottom).offset(10)
            make.width.equalTo(self).multipliedBy(0.8)
            make.left.equalTo(self).offset(15)
            make.height.equalTo(20)
        }
        
        language.snp.makeConstraints { (make) in
            make.top.equalTo(html.snp_bottom).offset(5)
            make.left.width.height.equalTo(html)
        }
        
        stars.snp.makeConstraints { (make) in
            make.top.equalTo(language.snp_bottom).offset(5)
            make.left.width.height.equalTo(html)
        }
        
        forks.snp.makeConstraints { (make) in
            make.top.equalTo(stars.snp_bottom).offset(5)
            make.left.width.height.equalTo(html)
        }
        
        openIssues.snp.makeConstraints { (make) in
            make.top.equalTo(forks.snp_bottom).offset(5)
            make.left.width.height.equalTo(html)
        }
        
        created.snp.makeConstraints { (make) in
            make.top.equalTo(openIssues.snp_bottom).offset(5)
            make.left.width.height.equalTo(html)
        }
        
        
        readmeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(created.snp_bottom).offset(10)
            make.width.equalTo(self).multipliedBy(0.9)
            make.centerX.equalTo(self)
        }
        readme.snp.makeConstraints { (make) in
            make.top.equalTo(readmeLabel.snp_bottom).offset(5)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.9)
            make.bottom.equalTo(self)
        }
    }
    
    func fillUI() {
        guard let vm = viewModel else {return}
        let width = screenWidth()
        
        
        
        author.text?                    = vm.userName
         html.propertyValue.text        = vm.htmlURL
         language.propertyValue.text    = vm.language
         stars.propertyValue.text       = vm.starsCount
         forks.propertyValue.text       = vm.forksCount
         created.propertyValue.text     = vm.created
         openIssues.propertyValue.text  = vm.openIssues
         avatar.image                   = vm.userImage
        
        avatar.snp.makeConstraints { (make) in
            make.height.width.equalTo(width * 0.3)
            
        }
    }
    
    
    fileprivate func  screenWidth() -> CGFloat{
        let size = UIScreen.main.bounds.size
        let width = size.width
        return width
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
