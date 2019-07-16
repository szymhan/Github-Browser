//
//  SHTopView.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 14/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit
import SearchTextField
import SnapKit

class SHTopView: UIView {
    
    
    let titleLabel = SHLabel(text: "Repository Browser", color: .white, size: 26, textAlign: .center, font: .robotoBold)
    let subtitleLabel = SHLabel(text: "Fill the search field below and use the filters to search through Git Hub repositories", color: .white, size: 12, textAlign: .justified)
    
    let searchIcon:UIImageView = {
       let si = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        si.translatesAutoresizingMaskIntoConstraints = false
        si.image        = UIImage(named: "mini-search")
        si.contentMode  = .scaleAspectFit
        return si
    }()
    
    
    let searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.theme.bgColor = .white
        textField.filterStrings(["red","yellow"])
        //creating header for the Last Searched hints
        textField.customHeaderwithText("Last Searched")
        textField.textColor     = .white
        textField.font          = UIFont.init(font: .robotoRegular, size: 16)
        let placeHolderFont     = UIFont.init(font: .robotoLightItalic, size: 13)
        textField.customAttributedPlaceholderWithFont(placeHolderFont, text: "Fill this field with search text", andFontColor: .white)
        //adding white bottom border to the field
        textField.addBottomBorder(color: UIColor.white, margins: 0, borderLineSize: 1)
        textField.returnKeyType = UIReturnKeyType.go
        //creating maginfier icon for textField leftView
        //startVisible=true allows to show last searched queries on field focus
        textField.startVisible  = true
        return textField
    }()
    
    
    // var delegate: SHHeaderDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.checkIfAutoLayout()
        
        backgroundColor = .iphoneBlue
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(searchIcon)
        self.addSubview(searchTextField)
        fillUI()
        
    }
    
    func fillUI() {
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp_centerYWithinMargins)
            make.left.equalTo(self.snp_left).offset(20)
            make.width.equalTo(self.snp_width).offset(-100)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(subtitleLabel.snp_top).offset(-5)
            make.centerX.equalTo(self.snp_centerX)
        }
        
        //searchTextField.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5).isActive = true
        searchIcon.snp.makeConstraints { (make) in
            make.leading.equalTo(subtitleLabel)
            make.bottom.equalTo(self).offset(-5)
            make.height.equalTo(20)
        }
        searchTextField.snp.makeConstraints{(make) in
            make.left.equalTo(searchIcon.snp_right).offset(5)
            make.trailing.equalTo(subtitleLabel)
            make.bottom.equalTo(self).offset(-5)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
