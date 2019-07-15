//
//  UIFont_+_init.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 15/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit


extension UIFont {
    convenience init? (font: FontsEnum, size: CGFloat) {
        self.init(name: font.rawValue, size: size)
    }
}
