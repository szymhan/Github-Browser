//
//  CheckBoxLabelPairView.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 24/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit


class CheckBoxLabelPairView: UIView {
    
    let label         = SHLabel(text: "", textAlign: .right, font: .helveticaRegular)
    
    let checkBox:SHCheckBox = {
        let rc = SHCheckBox(tag:"",frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        rc.checkedBorderColor   = .checkboxBlue
        rc.uncheckedBorderColor = .grayOne
        rc.checkmarkColor       = .checkboxBlue
        rc.borderStyle          = .square
        rc.checkmarkStyle       = .tick
        rc.useHapticFeedback    = true
        return rc
    }()
    
    init(frame: CGRect = .zero,  tag: String, isChecked:Bool) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.label.text         = tag
        self.checkBox.name      = tag
        self.checkBox.isChecked = isChecked
        
        self.addSubview(label)
        self.addSubview(checkBox)
        setUI()
    }
    
    func setUI() {
        label.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.height.equalTo(15)
            make.bottom.equalTo(self)
        }
        
        checkBox.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp_right).offset(5)
            make.centerY.equalTo(label.snp_centerY)
            make.width.height.equalTo(15)
        }
        
        
    }
    
    func getCheckBox() -> SHCheckBox {
        return self.checkBox
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
