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
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(topView)
        self.view.addSubview(filterView)
        self.view.addSubview(tableView)
        fillUI()
        setDelegates()
        addGestureRecognizers()
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
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(filterView.snp_bottom)
            make.bottom.width.equalTo(self.view)
        }
    }
    func setDelegates() {
        filterView.expandingDelegate = self
    }
    
    func addGestureRecognizers() {
        let viewTapGestureRec = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        //this line is important
        viewTapGestureRec.cancelsTouchesInView = false
        self.view.addGestureRecognizer(viewTapGestureRec)
    }
    
    @objc func handleViewTap() {
        topView.searchTextField.resignFirstResponder()
        filterView.authorTextField.resignFirstResponder()
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

extension RepositoriesBrowserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}


