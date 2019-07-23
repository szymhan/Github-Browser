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
    
    
    // SETTINH LEFT VIEW ICON WITH WHITE MAGNIFIER ICON
    func setLeftViewMagnifierIcon() {
        let searchIcon:UIImageView = {
            let si = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            //si.translatesAutoresizingMaskIntoConstraints = false
            si.image        = UIImage(named: "mini-search")
            si.contentMode  = .scaleAspectFit
            return si
        }()
        
        self.leftView = searchIcon
        self.leftViewMode = .always
    }
    
    
    
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
    
    
    // ADDING BOTTOM BORDER TO SEARCHFIELD
    static let padding = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: SearchTextField.padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: SearchTextField.padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: SearchTextField.padding)
    }
    
    override open func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 5
        let width  = 20
        let height = width
        let x = offset
        let leftViewBounds = CGRect(x: x, y: x/2, width: width, height: height)
        return leftViewBounds
    }
}
