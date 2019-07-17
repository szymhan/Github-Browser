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

enum ExpandedViewOption {
    case visible
    case hidden
}

class RepositoriesBrowserViewController: UIViewController {
    
    //MARK: VIEWS
    let topView     = SHTopView()
   // let filterView  = SHFilterView()
    let tableView: UITableView = {
       let tv = UITableView()
        tv.separatorStyle   = .none
        return tv
    }()
    let showMoreFilters:UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("show more filters", for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 0)
    
        return button
    }()
//    let repositoriesCell = RepositoriesTableViewCell(style: .default, reuseIdentifier: "repositories_identifier" )
    let filtersCell = FiltersTableViewCell(style: .subtitle, reuseIdentifier: "filters_identifier")
    
    //MARK: VIEWMODEL
    var repositoriesViewModel: RepositoriesEditorViewModel? {
        didSet {
            handleTableViewDataReloading()
        }
    }
    //MARK: VARIABLES
    var isFiltersCellExpanded:Bool = true
    var expandedFiltersView:ExpandedViewOption = .hidden {
        didSet {
            switch expandedFiltersView {
            case .hidden:
                showMoreFilters.setTitle("show filters", for: .normal)
            case .visible:
                showMoreFilters.setTitle("hide filters", for: .normal)
            }
        }
    }
    
    //MARK: CONSTANTS
    //
    let REPOSITORIES_IDENTIFIER:String  = "repositories_identifier"
    let FILTERS_IDENTIFIER:String       = "filters_identifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(topView)
        self.view.addSubview(tableView)
        fillUI()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        setDelegates()
        addGestureRecognizers()
    }

    
    func fillUI() {
        topView.snp.makeConstraints{ (make) in
            make.top.left.right.equalTo(self.view)
            //make.height.equalTo(self.view).multipliedBy(0.20)
        }
        tableView.snp.makeConstraints { (make) in
            make.bottom.width.equalTo(self.view)
            make.top.equalTo(topView.snp_bottom).offset(2)
            
        }
    }
    func setDelegates() {
        //filterView.expandingDelegate = self
        topView.searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RepositoriesTableViewCell.self, forCellReuseIdentifier: REPOSITORIES_IDENTIFIER)
        tableView.register(FiltersTableViewCell.self, forCellReuseIdentifier: FILTERS_IDENTIFIER)
    }
    
    func addGestureRecognizers() {
        let viewTapGestureRec = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        //this line is important
        viewTapGestureRec.cancelsTouchesInView = false
        self.view.addGestureRecognizer(viewTapGestureRec)
    }
    
    @objc func handleViewTap() {
        topView.searchTextField.resignFirstResponder()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}



extension RepositoriesBrowserViewController {
    func handleTableViewDataReloading() {
        
    }
    
    func buildURL(){
        let query:String = QueryBuilder.build(fromText: topView.searchTextField.text)
    }
}

extension RepositoriesBrowserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            switch expandedFiltersView {
            case .hidden:
                return 0
            case .visible:
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // if indexPath.count == 0 {
        print("assigning cell...")
 //          let cell = tableView.dequeueReusableCell(withIdentifier: FILTERS_IDENTIFIER , for: indexPath) as! FiltersTableViewCell
            let cell = filtersCell
            return cell
//        } else {
//            let cell = repositoriesCell
////            let cell = tableView.dequeueReusableCell(withIdentifier: REPOSITORIES_IDENTIFIER , for: indexPath) as! RepositoriesTableViewCell
//            return cell
      //  }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            showMoreFilters.addTarget(self, action: #selector(handleExpandHide), for: .touchUpInside)
            return showMoreFilters
        } else {
            return nil
        }
    }
    
    
    @objc func handleExpandHide() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        switch expandedFiltersView {
        case .visible:
            expandedFiltersView = .hidden
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        case .hidden:
            expandedFiltersView = .visible
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
            //self.tableView.deleteRows(at: [0], with: .fade)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension RepositoriesBrowserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}




