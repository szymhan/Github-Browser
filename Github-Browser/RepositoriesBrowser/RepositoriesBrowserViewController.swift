//
//  RepositoriesBrowserViewController.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 14/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit
import SearchTextField
import SnapKit

class RepositoriesBrowserViewController: UIViewController {
    
    let topView = SHTopView()
    let filterView = SHFilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(topView)
        self.view.addSubview(filterView)
        fillUI()
        setDelegates()
    }
    
    func fillUI() {
        topView.snp.makeConstraints{ (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.15)
        }
        filterView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp_bottom).offset(5)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.10)
        }
    }
    func setDelegates() {
        filterView.expandingDelegate = self
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension RepositoriesBrowserViewController : ViewExpanding {
    
    func expand(view: UIView) {
        UIView.animate(withDuration: 1) {
            view.subviews.forEach({ (view) in
                view.isHidden = false
            })
            view.sizeToFitCustom()
        }
    }
    
    func hide(view: UIView) {
        UIView.animate(withDuration: 1) {
            view.subviews.forEach({ (view) in
                view.isHidden = true
            })
            view.snp.remakeConstraints { (make) in
                make.height.equalTo(0)
            }
        }
        
    }
    
}
