//
//  FiltersTableViewCell.swift
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
    let authorLabel         = SHLabel(text: "author name :", textAlign: .right, font: .helveticaRegular)
    let searchInLabel       = SHLabel(text: "search in :", textAlign: .right, font: .helveticaRegular)
    let sortByLabel         = SHLabel(text: "sort by :", textAlign: .right, font: .helveticaRegular)
    let languageLabel       = SHLabel(text: "language :", textAlign: .right, font: .helveticaRegular)

    
    let nameCheckBox = CheckBoxLabelPairView( tag: "name", isChecked: true)
    let descriptionCheckBox = CheckBoxLabelPairView( tag: "description", isChecked: true)
    let readmeCheckBox = CheckBoxLabelPairView(tag: "readme", isChecked: false)
    
    //MARK: TEXTFIELDS
    let authorTextField: SHTextField = {
        let tf = SHTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addBottomBorder(color: .black, margins: 0, borderLineSize: 0.5)
        tf.font = UIFont.init(font: .helveticaRegular, size: 14)
        let font = UIFont.init(font: .robotoLightItalic, size: 12)
        tf.attributedPlaceholder = NSAttributedString(string: "(optional) default: all",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: font!])
        tf.textColor = .black
        tf.disableAutoTypes()
        return tf
    }()
    
    let languageTextField: SHSearchTextField = {
       let tf = SHSearchTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.theme.bgColor = .white
        tf.textColor        = .black
        tf.font             = UIFont.init(font: .helveticaRegular, size: 14)
        let placeHolderFont = UIFont.init(font: .robotoLightItalic, size: 12)
        tf.customAttributedPlaceholderWithFont(placeHolderFont, text: "(optional) default:all", andFontColor: .gray)
        //adding white bottom border to the field
        tf.addBottomBorder(color: .black, margins: 0, borderLineSize: 0.5)
        //maximum number of shown hints
        tf.maxNumberOfResults   = 5
        //creating maginfier icon for textField leftView
        tf.startVisible         = true
        tf.disableAutoTypes()
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
        dd.insertText("Best match")
        return dd
    }()
    
    // MARK: VIEWS
    let searchIcon: UIButton = {
        let si = UIButton()
        si.translatesAutoresizingMaskIntoConstraints = false
        si.setImage(UIImage(named: "blue_search"), for: UIControl.State.normal)
        
        return si
    }()
    
    //MARK: VARIABLES
    
    let isExpanded:Bool = false
    
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
        self.addSubview(nameCheckBox)
        self.addSubview(descriptionCheckBox)
        self.addSubview(readmeCheckBox)
        self.addSubview(searchIcon)
        setUI()
        loadPlist()
    }
    
    fileprivate func loadPlist() {
        PlistManager.shared.getDictionaryFrom("Languages") { (result, err) in
            if err != nil {
                print("\(err.debugDescription) for Languages.plist")
                languageTextField.filterStrings([])
                return
            }
            guard let languagesArray = result?.allKeys else {
                languageTextField.filterStrings([])
                return
            }
            languageTextField.filterStrings(languagesArray as! [String])
        }
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
            make.width.equalTo(self).multipliedBy(0.6)
           // make.height.equalTo(20)
        }
        
        languageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp_bottom).offset(15)
            make.left.width.equalTo(authorLabel)
        }
        
        languageTextField.snp.makeConstraints { (make) in
            make.left.equalTo(languageLabel.snp_right).offset(10)
            make.centerY.equalTo(languageLabel.snp_centerY).labeled("language textfield Xcentered to label")
            make.width.equalTo(authorTextField)
        }
        
        sortByLabel.snp.makeConstraints { (make) in
            make.top.equalTo(languageLabel.snp_bottom).offset(15)
            make.left.width.equalTo(authorLabel)
        }

        sortDropDown.snp.makeConstraints { (make) in
            make.left.width.equalTo(authorTextField)
            make.height.equalTo(30)
            make.centerY.equalTo(sortByLabel.snp_centerY).labeled("sort dropdown Xcentered to label")
        }

        searchInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sortByLabel.snp_bottom).offset(15)
            make.left.width.equalTo(authorLabel)
            make.bottom.equalTo(self).offset(-10)
        }
        
        descriptionCheckBox.snp.makeConstraints { (make) in
            make.top.equalTo(searchInLabel)
            make.left.equalTo(authorTextField)
            make.width.equalTo(languageTextField.snp_width).multipliedBy(0.4)
        }
        
        nameCheckBox.snp.makeConstraints { (make) in
            make.top.equalTo(searchInLabel)
            make.left.equalTo(descriptionCheckBox.snp_right).offset(5)
            make.width.equalTo(languageTextField.snp_width).multipliedBy(0.25)
        }
        
        readmeCheckBox.snp.makeConstraints { (make) in
            make.top.equalTo(searchInLabel)
            make.left.equalTo(nameCheckBox.snp_right).offset(5)
            make.width.equalTo(languageTextField.snp_width).multipliedBy(0.35)
        }
        
        searchIcon.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.centerY.equalTo(nameCheckBox)
            make.right.equalTo(self).offset(-10)
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
