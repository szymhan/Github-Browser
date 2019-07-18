//
//  Protocols.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 14/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit

protocol Animating {
     func animate(view: UIView,condition: @escaping () -> Void)
}

protocol ViewExpanding {
    func expand(view:UIView)
    func hide(view: UIView)
}

protocol QueryElementDelegate {
    func returnContent() -> String?
}


