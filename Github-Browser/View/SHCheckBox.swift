//
//  SHCheckBox.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 17/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit


class SHCheckBox: Checkbox, QueryElementDelegate {
    var name:String = ""
    convenience init(tag: String, frame: CGRect) {
        self.init(frame: frame)
        name = tag
    }
    
    func returnContent() -> String? {
        if self.isChecked{
            return self.name
        }else {
            return nil
        }
    }
}
