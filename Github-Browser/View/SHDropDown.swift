//
//  SHDropDown.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 17/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import iOSDropDown


class SHDropDown: DropDown, QueryElementDelegate {
    func returnContent() -> String? {
        if let text = self.text {
            return text
        } else {
            return ""
        }
    }
}

