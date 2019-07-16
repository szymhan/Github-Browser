//
//  RepositoriesTableViewCell.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 16/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit
import SnapKit


class RepositoriesTableViewCell: UITableViewCell {
    
    
    private let REPOSITORY_CELL_IDENTIFIER = "RepositoryCellIdentifier"
    let tableView = UITableView()
    var repositoriesViewModel:RepositoriesEditorViewModel? {
        didSet {
            fillUI()
            tableView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubview(tableView)
        setUI()
        setDelegates()
    }
    
    func setUI() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
      
    }
    
    func fillUI(){
        
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.register(SingleRepositoryTableViewCell.self, forCellReuseIdentifier: REPOSITORY_CELL_IDENTIFIER)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RepositoriesTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let delegate = repositoriesViewModel {
        if repositoriesViewModel?.repositories.count == 0 {
        tableView.setEmptyView(title: "Run the search above.", message: "Found repositories will be there.")
            } else {
                tableView.restore()
                return delegate.repositories.count
            }
        } else {
            tableView.setEmptyView(title: "No data to show yet.", message: "Run search to let me show you some results.")
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REPOSITORY_CELL_IDENTIFIER , for: indexPath)
        return cell
    }
    
    
}
