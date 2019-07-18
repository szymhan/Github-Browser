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

    
    
    let searchTextField: SHMainSearchTextField = {
        let textField = SHMainSearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        //textField.theme.bgColor = .black
        textField.backgroundColor = .lighteriPhoneBlue
        textField.layer.cornerRadius = 10
        textField.filterStrings(["red","yellow"])
        //creating header for the Last Searched hints
        textField.customHeaderwithText("Last Searched")
        textField.textColor     = .white
        textField.font          = UIFont.init(font: .robotoRegular, size: 16)
        let placeHolderFont     = UIFont.init(font: .robotoLightItalic, size: 13)
        textField.customAttributedPlaceholderWithFont(placeHolderFont, text: "Search", andFontColor: .white)
        //adding white bottom border to the field
        textField.disableAutoTypes()
        textField.returnKeyType = UIReturnKeyType.go
        //startVisible=true allows to show last searched queries on field focus
        textField.startVisible  = true
        textField.setMagnifierIcon()
        return textField
    }()
    
    
    // var delegate: SHHeaderDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.checkIfAutoLayout()
        
        backgroundColor = .iphoneBlue
        
        self.addSubview(titleLabel)
        self.addSubview(searchTextField)
        fillUI()
        
    }
    
    func fillUI() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.equalTo(self).offset(20)
        }
        
        searchTextField.snp.makeConstraints{(make) in
            make.width.equalTo(self).multipliedBy(0.8)
            make.bottom.equalTo(self).offset(-5)
            make.centerX.equalTo(self)
            make.top.equalTo(titleLabel.snp_bottom).offset(20)
            make.height.equalTo(25)
        }
        
        self.sizeToFitCustom()
    
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
