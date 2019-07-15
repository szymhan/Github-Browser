//
//  SHLabel.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 14/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit

class SHLabel: UILabel {
    init(text:String, color:UIColor = .white, size:CGFloat=16, textAlign:NSTextAlignment = .center,
         font:Fonts = .robotoRegular) {
        super.init(frame: .zero)
        self.text = text
        self.textColor=color
        self.textAlignment=textAlign
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.init(name: font.rawValue,size: size)
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines=0
        
    }
    
    func getText() -> String {
        return self.text!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
