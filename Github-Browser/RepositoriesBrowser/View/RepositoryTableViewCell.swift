//
//  RepositoryTableViewCell.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 14/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit

class LanguageColorDictionary {
    
    let dictionary: [String:Int]
    init() {
        dictionary = [
            "Ruby": 0xff6b81,
            "C": 0x2ed573,
            "Shell":0xf35422,
            "TypeScript":0x1e90ff,
            "C#":0xffa502,
            "C++":0x7bed9f,
            "PHP":0x70a1ff,
            "Python":0xff4757,
            "Java":0x3742fa,
            "JavaScript":0xeccc68,
        ]
    }
}

protocol LanguageColorDictionaryManager {
    var dictionary: LanguageColorDictionary {get}
}
fileprivate let sharedLanguageColorDictionaryManager: LanguageColorDictionary = LanguageColorDictionary()

extension LanguageColorDictionaryManager {
    var dictionary: LanguageColorDictionary {
        return sharedLanguageColorDictionaryManager
    }
}


//MARK: representation of a single cell in table view reperesting queried github repositories
class RepositoryTableViewCell: UITableViewCell {
    
    
    
    //MARK: VIEWS
    let authorImage: UIImageView = {
        let oi = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        oi.contentMode = .scaleAspectFit
        return oi
    }()
    
    let starsIcon:UIImageView = {
        let si = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        //si.translatesAutoresizingMaskIntoConstraints = false
        si.image        = UIImage(named: "star_icon")
        si.contentMode  = .scaleAspectFit
        return si
    }()
    
    let forksIcon:UIImageView = {
        let si = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        //si.translatesAutoresizingMaskIntoConstraints = false
        si.image        = UIImage(named: "fork_icon")
        si.contentMode  = .scaleAspectFit
        return si
    }()
    
    //MARK: LABELS
    let repoName    = SHLabel(text: "",  size: 14, textAlign: .left, font: .helveticaBold)
    let authorLabel = SHLabel(text: "by ", size: 14, textAlign: .left, font: .helveticaRegular)
    let starsCount  = SHLabel(text: "", size: 12, textAlign: .left, font: .helveticaRegular)
    let forksCount  = SHLabel(text: "", size: 12, textAlign: .left, font: .helveticaRegular)
    
    let languageLabel: SHLabel = {
        let label = SHLabel(text: "", color: .gray, size: 12, textAlign: .center, font: .helveticaRegular)
        label.layer.borderColor     = label.textColor.cgColor
        label.layer.borderWidth     = 0.25
        label.layer.cornerRadius    = 5
        return label
    }()
    
    var viewModel:RepositoryViewModel? {
        didSet {
            fillUI()
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.addSubview(authorImage)
        self.addSubview(repoName)
        self.addSubview(languageLabel)
        self.addSubview(authorLabel)
        self.addSubview(starsIcon)
        self.addSubview(starsCount)
        self.addSubview(forksIcon)
        self.addSubview(forksCount)
        setUI()
        
    }
    
    func setUI() {
        let width = self.frame.size.width
        
        authorImage.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.bottom.equalTo(self).offset(-5)
        }
        
        repoName.snp.makeConstraints { (make) in
            make.left.equalTo(authorImage.snp_right).offset(15)
            make.width.equalTo(self).multipliedBy(0.5)
            make.top.equalTo(authorImage).offset(5)
        }
        
        languageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(repoName)
            make.left.equalTo(repoName.snp_right).offset(5)
            make.right.equalTo(self).offset(-10)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(repoName)
            make.height.equalTo(15)
            make.bottom.equalTo(authorImage)
        }
        
        starsIcon.snp.makeConstraints { (make) in
            make.height.equalTo(15)
            make.left.equalTo(self).offset(width*0.75)
            make.centerY.equalTo(authorLabel)
        }
        
        starsCount.snp.makeConstraints { (make) in
            make.left.equalTo(starsIcon.snp_right)
            make.centerY.equalTo(authorLabel)
            make.height.equalTo(15)
        }
        
        forksIcon.snp.makeConstraints { (make) in
            make.left.equalTo(starsIcon.snp_right).offset(25)
            make.centerY.equalTo(authorLabel)
            make.height.equalTo(10)
        }
        
        forksCount.snp.makeConstraints { (make) in
            make.left.equalTo(forksIcon.snp_right).offset(2)
            make.centerY.equalTo(authorLabel)
            make.height.equalTo(10)
        }
    }
    
    func fillUI() {
        guard let viewModel = viewModel else {return}
        let size = UIScreen.main.bounds.size
        let width = size.width * 0.15
        
        if let image = viewModel.userImage{
            authorImage.maskCircle(anyImage: image, andSize: width)
        } else {
            authorImage.maskCircle(anyImage: UIImage(named: "default_user_icon")!, andSize: width)
        }
        repoName.text? = viewModel.repositoryName
        languageLabel.text? =  viewModel.language
        authorLabel.text? = "by \(viewModel.userName)"
        starsCount.text? =  viewModel.starsCount
        forksCount.text? = viewModel.forksCount
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
