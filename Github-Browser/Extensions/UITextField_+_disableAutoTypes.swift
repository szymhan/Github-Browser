//
//  UITextField_+_disableAutoTypes.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 17/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit

extension UITextField {
    
    func disableAutoTypes() {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
    }
}
