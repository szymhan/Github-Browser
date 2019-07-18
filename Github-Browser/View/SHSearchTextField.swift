//
//  MySearchTextField.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 17/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import SearchTextField


class SHSearchTextField: SearchTextField,QueryElementDelegate {
    
    func returnContent() -> String? {
        if let text = self.text{
            if text == "" {
                return nil
            }
        return text
        } else {
            return nil
        }
    }
    
    
    
    static let shPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: SHSearchTextField.shPadding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: SHSearchTextField.shPadding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: SHSearchTextField.shPadding)
    }
}
