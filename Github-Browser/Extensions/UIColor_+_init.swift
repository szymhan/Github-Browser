//
//  UIColor_+_init.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 14/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit

extension UIColor {
    static var grayText: UIColor {return UIColor.init(rgb: 0x5E6083)}
    static var checkboxBlue: UIColor {return UIColor.init(rgb: 0x74b9ff)}
    static var grayOne: UIColor {return UIColor.init(rgb: 0xb2bec3)}
    static var iphoneBlue: UIColor{return UIColor.init(rgb: 0x5fc9f8)}
    static var lighteriPhoneBlue: UIColor {return UIColor.init(rgb: 0x99DDFA)}
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue:  rgb & 0xFF
        )
    }
}

