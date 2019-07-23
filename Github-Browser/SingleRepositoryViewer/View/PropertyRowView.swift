//
//  PropertyRowView.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 21/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit
import SnapKit

class PropertyRowView: UIView {
    
    let propertyLabel = SHLabel(text: "", color: .black, size: 16, textAlign: .right, font: .helveticaRegular)
    let propertyValue = SHLabel(text: "", color: .black, size: 16, textAlign: .left, font: .helveticaRegular)
    
    init(labelName:String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        propertyLabel.text = labelName
        
        self.addSubview(propertyLabel)
        self.addSubview(propertyValue)
        setUI()
    }
    
    func setUI() {
        propertyLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.3)
        }
        
        propertyValue.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(self)
            make.left.equalTo(propertyLabel.snp_right).offset(5)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
