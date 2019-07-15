//
//  DropDown_+_insets.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 15/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import iOSDropDown


extension DropDown{
    
    static let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: DropDown.padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: DropDown.padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: DropDown.padding)
    }
}
