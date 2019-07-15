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
    let subtitleLabel = SHLabel(text: "Fill the search field below and use the filters to search through Git Hub repositories", color: .white, size: 14, textAlign: .justified)
    

    
    let searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.filterStrings(["red","yellow"])
        //creating header for the Last Searched hints
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: textField.frame.width, height: 20))
        header.text = "Last searched"
        header.textAlignment = .center
        header.font = UIFont.systemFont(ofSize: 14)
        textField.resultsListHeader = header
        textField.textColor = .white
        textField.font = UIFont.init(font: .robotoRegular, size: 12)
        if let font = UIFont.init(font: .robotoLightItalic, size: 12) {
            textField.attributedPlaceholder = NSAttributedString(string: "Fill this field with query text",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font])
        } else {
            textField.attributedPlaceholder = NSAttributedString(string: "Fill this field with query text",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        //adding white bottom border to the field
        textField.addBottomBorder(color: UIColor.white, margins: 0, borderLineSize: 1)
        textField.returnKeyType = UIReturnKeyType.go
        //creating maginfier icon
        let iconLabel = SHLabel(text: "🔍", color: .white, size: 12, textAlign: .left)
        textField.leftView = iconLabel
        textField.leftViewMode = .always
        //startVisible=true allows to show last searched queries on field focus
        textField.startVisible = true
        return textField
    }()
    
    
    // var delegate: SHHeaderDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.checkIfAutoLayout()
        
        backgroundColor = .grayOne
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(searchTextField)
        fillUI()
        
    }
    
    func fillUI() {
        
        
        subtitleLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant : 20).isActive = true
        subtitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -100).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -5).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        //searchTextField.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5).isActive = true
        searchTextField.snp.makeConstraints{(make) in
            make.leading.trailing.equalTo(subtitleLabel)
            make.bottom.equalTo(self).offset(-5)
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
