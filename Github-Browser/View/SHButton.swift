//
//  SHButton.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 14/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit

class SHButton: UIButton {
    init(frame: CGRect = .zero, title: String, bgColor: UIColor = .white, textColor:UIColor = .black, font:FontsEnum = .robotoBold, size:CGFloat = 14) {
        super.init(frame: frame)
        self.checkIfAutoLayout()
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.init(name: font.rawValue, size: size)
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = bgColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
