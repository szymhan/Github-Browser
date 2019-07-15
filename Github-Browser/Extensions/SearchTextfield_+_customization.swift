//
//  SearchTextfield_+_customizations.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 14/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit
import SearchTextField

extension SearchTextField {
    
    func customHeaderwithText(_ text:String) {
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 20))
        header.text = text
        header.textAlignment = .center
        header.font = UIFont.systemFont(ofSize: 14)
        self.resultsListHeader = header
    }
    
    func customAttributedPlaceholderWithFont(_ font: UIFont?, text:String, andFontColor fontColor: UIColor) {
        if let font = font {
        self.attributedPlaceholder = NSAttributedString(string: text,attributes: [NSAttributedString.Key.foregroundColor: fontColor, NSAttributedString.Key.font: font])
        } else {
            self.attributedPlaceholder = NSAttributedString(string: text,attributes: [NSAttributedString.Key.foregroundColor: fontColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        }
    }
    
    static let padding = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: SearchTextField.padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: SearchTextField.padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: SearchTextField.padding)
    }
}
