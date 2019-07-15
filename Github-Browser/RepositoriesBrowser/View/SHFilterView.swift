//
//  SHFilterView.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 14/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit
import SnapKit
import DynamicButton
import iOSDropDown

enum ExpandedViewOption {
    case visible
    case hidden
}

class SHFilterView: UIView {
    var frameHight: CGFloat = 0
    var expandingDelegate: ViewExpanding?
    var isFilterViewExpanded:ExpandedViewOption = .hidden {
        didSet {
            switch isFilterViewExpanded {
            case .visible:
                if let delegate = expandingDelegate{
                    delegate.expand(view: contentView)
                }
                expandButton.style = .arrowUp
                expandButton.strokeColor = .checkboxBlue
            case .hidden:
                if let delegate = expandingDelegate {
                    delegate.hide(view: contentView)
                }
                expandButton.style = .arrowDown
                expandButton.strokeColor = .black
            }
        }
    }
    
    //VIEWS
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
 
    // LABELS
    let authorLabel = SHLabel(text: "author name :", color: .black, size: 12, textAlign: .right, font: .robotoRegular)
    let searchInLabel = SHLabel(text: "search in :", color: .black, size: 12, textAlign: .right, font: .robotoRegular)
    let readmeLabel = SHLabel(text: "readme", color: .black, size: 12, textAlign: .left, font: .robotoRegular)
    let sortByLabel = SHLabel(text: "sort by :", color: .black, size: 12, textAlign: .right, font: .robotoRegular)
    
    // BUTTONS
    let expandButton:DynamicButton = {
        let eb = DynamicButton()
        eb.setStyle(.arrowDown, animated: true)
        eb.lineWidth           = 2
        eb.strokeColor         = .black
        eb.highlightStokeColor = .checkboxBlue
        return eb
    }()
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
    
    //TEXTFIELDS
    let authorTextField: UITextField = {
       let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addBottomBorder(color: .black, margins: 0, borderLineSize: 0.5)
        tf.font = UIFont.init(font: .robotoRegular, size: 11)
        let font = UIFont.init(font: .robotoLightItalic, size: 10)
        tf.attributedPlaceholder = NSAttributedString(string: "author's nickname (optional, default: all)",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: font!])
        return tf
    }()
    
    let sortDropDown: DropDown = {
        let dd = DropDown(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
        dd.font = UIFont.init(font: .robotoLightItalic, size: 10)
        dd.optionArray      = SortOptions.allCases()
        dd.selectedIndex    = 0
        dd.cornerRadius     = 5
        dd.borderWidth      = 0.1
        dd.isSearchEnable   = false
        dd.selectedRowColor = .white
        dd.insertText("default: Best match desc")
        return dd
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addSubview(expandButton)
        self.addSubview(contentView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(authorTextField)
        contentView.addSubview(sortByLabel)
        contentView.addSubview(sortDropDown)
        contentView.addSubview(searchInLabel)
        contentView.addSubview(readmeLabel)
        contentView.addSubview(readmeCheckbox)
        setUI()
        assignSelectorsToUI()
    }
    
    func assignSelectorsToUI() {
        expandButton.addTarget(self, action: #selector(self.handleExpandingView), for: .touchUpInside)
    }
    
    @objc func handleExpandingView() {
        switch isFilterViewExpanded {
        case .visible:
            isFilterViewExpanded = .hidden
        case .hidden:
            isFilterViewExpanded = .visible
        }
    }
    
    func setUI() {
        expandButton.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.height.width.equalTo(20)
        }
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(expandButton.snp_bottom).offset(10)
            make.width.height.lessThanOrEqualToSuperview()
        }
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp_top)
            make.left.equalTo(contentView).offset(5)
        }
        authorTextField.snp.makeConstraints { (make) in
            make.left.equalTo(authorLabel.snp_right).offset(10)
            make.centerY.equalTo(authorLabel.snp_centerY).labeled("author textfield Xcentered to label")
            make.width.equalTo(contentView).multipliedBy(0.5)
            make.height.equalTo(20)
        }
        
        sortByLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp_bottom).offset(10)
            make.left.width.equalTo(authorLabel)
        }
        
        sortDropDown.snp.makeConstraints { (make) in
            make.left.width.equalTo(authorTextField)
            make.height.equalTo(20)
            make.centerY.equalTo(sortByLabel.snp_centerY).labeled("sort dropdown Xcentered to label")
        }
        
        searchInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sortByLabel.snp_bottom).offset(10)
            make.left.width.equalTo(authorLabel)
        }
        readmeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(searchInLabel)
            make.left.equalTo(searchInLabel.snp_right).offset(5)
        }
        readmeCheckbox.snp.makeConstraints { (make) in
            make.left.equalTo(readmeLabel.snp_right).offset(5)
            make.centerY.equalTo(readmeLabel.snp_centerY)
            make.width.height.equalTo(15)
        }
       
        contentView.sizeToFitCustom()
        hideFilterView()
    }
    
    func hideFilterView() {
        contentView.snp.makeConstraints{ (make) in
            make.height.equalTo(0)
        }
        contentView.subviews.forEach{$0.isHidden = true}
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
