//
//  SHFilterView.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 14/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit
import SnapKit
import SearchTextField
import iOSDropDown


class FiltersTableViewCell: UITableViewCell {

    
    //MARK: LABELS
    let authorLabel = SHLabel(text: "author name :", textAlign: .right, font: .helveticaRegular)
    let searchInLabel = SHLabel(text: "search in :", textAlign: .right, font: .helveticaRegular)
    let readmeLabel = SHLabel(text: "readme", textAlign: .left, font: .helveticaRegular)
    let sortByLabel = SHLabel(text: "sort by :", textAlign: .right, font: .helveticaRegular)
    let languageLabel = SHLabel(text: "language :", textAlign: .right, font: .helveticaRegular)
    let nameLabel = SHLabel(text: "name",  textAlign: .left, font: .helveticaRegular)
    let descriptionLabel = SHLabel(text: "description", textAlign: .left, font: .helveticaRegular)
    
    //MARK: BUTTONS
    let readmeCheckbox:Checkbox = {
        let rc = Checkbox(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        rc.checkedBorderColor   = .checkboxBlue
        rc.uncheckedBorderColor = .grayOne
        rc.checkmarkColor       = .checkboxBlue
        rc.borderStyle          = .square
        rc.checkmarkStyle       = .tick
        rc.useHapticFeedback    = true
        return rc
    }()
    let descriptionCheckBox:Checkbox = {
        let rc = Checkbox(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        rc.checkedBorderColor   = .checkboxBlue
        rc.uncheckedBorderColor = .grayOne
        rc.checkmarkColor       = .checkboxBlue
        rc.borderStyle          = .square
        rc.checkmarkStyle       = .tick
        rc.useHapticFeedback    = true
        rc.isChecked            = true
        return rc
    }()
    let nameCheckbox:Checkbox = {
        let rc = Checkbox(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        rc.checkedBorderColor   = .checkboxBlue
        rc.uncheckedBorderColor = .grayOne
        rc.checkmarkColor       = .checkboxBlue
        rc.borderStyle          = .square
        rc.checkmarkStyle       = .tick
        rc.useHapticFeedback    = true
        rc.isChecked            = true
        return rc
    }()
    //MARK: TEXTFIELDS
    let authorTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addBottomBorder(color: .black, margins: 0, borderLineSize: 0.5)
        tf.font = UIFont.init(font: .helveticaRegular, size: 14)
        let font = UIFont.init(font: .robotoLightItalic, size: 12)
        tf.attributedPlaceholder = NSAttributedString(string: "(optional) default: all",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: font!])
        tf.textColor = .black
        return tf
    }()
    
    let languageTextField: SearchTextField = {
       let tf = SearchTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.theme.bgColor = .white
        tf.filterStrings(["red","yellow"])
        tf.textColor        = .black
        tf.font             = UIFont.init(font: .helveticaRegular, size: 14)
        let placeHolderFont = UIFont.init(font: .robotoLightItalic, size: 12)
        tf.customAttributedPlaceholderWithFont(placeHolderFont, text: "(optional) default:all", andFontColor: .gray)
        //adding white bottom border to the field
        tf.addBottomBorder(color: .black, margins: 0, borderLineSize: 0.5)
        //creating maginfier icon for textField leftView
        tf.startVisible  = true
        return tf
    }()
    
    let sortDropDown: DropDown = {
        let dd = DropDown(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
        dd.font = UIFont.init(font: .robotoLightItalic, size: 12)
        dd.optionArray      = SortOptions.allCases()
        dd.selectedIndex    = 0
        dd.cornerRadius     = 5
        dd.borderWidth      = 0.1
        dd.isSearchEnable   = false
        dd.selectedRowColor = .white
        dd.insertText("default: Best match")
        return dd
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubview(authorLabel)
        self.addSubview(authorTextField)
        self.addSubview(languageLabel)
        self.addSubview(languageTextField)
        self.addSubview(sortByLabel)
        self.addSubview(sortDropDown)
        self.addSubview(searchInLabel)
        self.addSubview(nameLabel)
        self.addSubview(nameCheckbox)
        self.addSubview(descriptionLabel)
        self.addSubview(descriptionCheckBox)
        self.addSubview(readmeLabel)
        self.addSubview(readmeCheckbox)
        setUI()
    }
    
    func setUI() {

        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(self).multipliedBy(0.25)
        }
        authorTextField.snp.makeConstraints { (make) in
            make.left.equalTo(authorLabel.snp_right).offset(10)
            make.centerY.equalTo(authorLabel.snp_centerY).labeled("author textfield Xcentered to label")
            make.width.equalTo(self).multipliedBy(0.5)
           // make.height.equalTo(20)
        }
        
        languageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp_bottom).offset(15)
            make.left.width.equalTo(authorLabel)
        }
        
        languageTextField.snp.makeConstraints { (make) in
            make.left.equalTo(languageLabel.snp_right).offset(10)
            make.centerY.equalTo(languageLabel.snp_centerY).labeled("language textfield Xcentered to label")
            make.width.equalTo(self).multipliedBy(0.5)
        }
        
        sortByLabel.snp.makeConstraints { (make) in
            make.top.equalTo(languageLabel.snp_bottom).offset(15)
            make.left.width.equalTo(authorLabel)
        }

        sortDropDown.snp.makeConstraints { (make) in
            make.left.width.equalTo(authorTextField)
            make.height.equalTo(25)
            make.centerY.equalTo(sortByLabel.snp_centerY).labeled("sort dropdown Xcentered to label")
        }

        searchInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sortByLabel.snp_bottom).offset(15)
            make.left.width.equalTo(authorLabel)
            make.bottom.equalTo(self).offset(-10)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(searchInLabel)
            make.left.equalTo(authorTextField)
        }
        
        nameCheckbox.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp_right).offset(5)
            make.centerY.equalTo(readmeLabel.snp_centerY)
            make.width.height.equalTo(15)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(searchInLabel)
            make.left.equalTo(nameCheckbox.snp_right).offset(5)
        }
        
        descriptionCheckBox.snp.makeConstraints { (make) in
            make.left.equalTo(descriptionLabel.snp_right).offset(5)
            make.centerY.equalTo(readmeLabel.snp_centerY)
            make.width.height.equalTo(15)
        }
            
        
        readmeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(searchInLabel)
            make.left.equalTo(descriptionCheckBox.snp_right).offset(5)
        }
            
        readmeCheckbox.snp.makeConstraints { (make) in
            make.left.equalTo(readmeLabel.snp_right).offset(5)
            make.centerY.equalTo(readmeLabel.snp_centerY)
            make.width.height.equalTo(15)
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
