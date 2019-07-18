//
//  SHTextField.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 17/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit

class SHTextField: UITextField, QueryElementDelegate {
    func returnContent() -> String? {
        if let text = self.text {
            if text == "" {
                return nil
            }
            return text
        } else {
            return nil
        }
    }
    
    
}
