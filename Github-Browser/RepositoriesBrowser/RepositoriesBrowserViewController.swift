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
import MKProgress

enum ExpandedViewOption {
    case visible
    case hidden
}

class RepositoriesBrowserViewController: UIViewController {
    
    //MARK: VIEWS
    let topView     = SHTopView()
   // let filterView  = SHFilterView()
    let filterTableView: UITableView = {
       let tv = UITableView()
        tv.isScrollEnabled  = false
        tv.separatorStyle   = .none
        return tv
    }()
    
    let repositoriesTableView: UITableView = {
       let rtv = UITableView(frame: UIScreen.main.bounds, style: .plain)
        rtv.tableFooterView = UIView()
        return rtv
    }()
    
    let showMoreFilters:UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("Show filters", for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: 20,bottom: 0,right: 0)
        return button
    }()
    
    let tableViewSectionHeader: SHPaddingLabel = {
       let tvsh = SHPaddingLabel(text: "", color: .black, size: 16, textAlign: .left, font: .helveticaBold)
        return tvsh
    }()
    // cell representing filters View
    let filtersCell: FiltersTableViewCell = {
      let fc = FiltersTableViewCell(style: .subtitle, reuseIdentifier: "filters_identifier")
        return fc
    }()
 
    
    //MARK: VIEWMODEL
    var viewModel: RepositoriesViewModel? {
        didSet {
            handleTableViewDataReloading()
        }
    }
    //MARK: VARIABLES
    var pagesLoaded:Int = 1
     private var feedbackGenerator: UIImpactFeedbackGenerator?
    var actualEndpoint:Endpoint?
    var isFiltersCellExpanded:Bool = true
    var expandedFiltersView:ExpandedViewOption = .hidden {
        didSet {
            switch expandedFiltersView {
            case .hidden:
                showMoreFilters.setTitle("Show filters", for: .normal)
                updateFilterViewheightConstraint()
            case .visible:
                showMoreFilters.setTitle("Hide filters", for: .normal)
                updateFilterViewheightConstraint()
            }
        }
    }
    var queryConstructor: QueryConstructor?
    var sortOrderConstructor = SortOrderBuilder(selectedText: "Best Match")
    let dataLoader = DataLoader()
    let errorWhileLoading   = "Eror while loading data from server"
    let checkConnection     = "Check your internet connection and try again later"
    let loadingFailed       = "Loading failed"
    let tryAgain            = "Please try again later"
    let close               = "Close"
    
    //MARK: CONSTANTS
    //
    let REPOSITORIES_IDENTIFIER:String  = "repositories_identifier"
    let FILTERS_IDENTIFIER:String       = "filters_identifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(topView)
        self.view.addSubview(filterTableView)
        self.view.addSubview(repositoriesTableView)
        fillUI()

        setDelegates()
        addGestureRecognizers()
    }
    
    override func viewDidLayoutSubviews() {
        let builder = QueryConstructorBuilder()
        queryConstructor = builder
            .appendText(topView.searchTextField)
            .appendLanguage(filtersCell.languageTextField)
            .appendUser(filtersCell.authorTextField)
            .appendIn([filtersCell.readmeCheckbox,
                       filtersCell.nameCheckbox,
                       filtersCell.descriptionCheckBox])
            .build()
        
        filtersCell.sortDropDown.didSelect { (selectedText, _, _) in
            self.sortOrderConstructor = SortOrderBuilder(selectedText: selectedText)
        }
        topView.searchTextField.lastSearched =  PersistentServiceHelper.fetchSearches()
    }
    
    func fillUI() {
        topView.snp.makeConstraints{ (make) in
            make.top.left.right.equalTo(self.view)
            //make.height.equalTo(self.view).multipliedBy(0.20)
        }
        
        filterTableView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(150)
            make.top.equalTo(topView.snp_bottom).offset(2)
        }
        
        repositoriesTableView.snp.makeConstraints { (make) in
            make.top.equalTo(filterTableView.snp_bottom)
            make.bottom.width.equalTo(self.view)
        }
        
        updateFilterViewheightConstraint()
    }
    
    func updateFilterViewheightConstraint() {
        
        switch expandedFiltersView {
        case .visible:
            filterTableView.snp.updateConstraints { (make) in
                make.height.equalTo(150)
            }
        case .hidden:
            filterTableView.snp.updateConstraints { (make) in
                make.height.equalTo(30)
            }
        }
    }
    
    func setDelegates() {
        topView.searchTextField.delegate    = self
        filterTableView.delegate            = self
        filterTableView.dataSource          = self
        repositoriesTableView.delegate      = self
        repositoriesTableView.dataSource    = self
        
        repositoriesTableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: REPOSITORIES_IDENTIFIER)
        filterTableView.register(FiltersTableViewCell.self, forCellReuseIdentifier: FILTERS_IDENTIFIER)
    }
    
    func addGestureRecognizers() {
        let viewTapGestureRec = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        //this line is important
        viewTapGestureRec.cancelsTouchesInView = false
        self.topView.addGestureRecognizer(viewTapGestureRec)
        self.filterTableView.addGestureRecognizer(viewTapGestureRec)
        self.repositoriesTableView.addGestureRecognizer(viewTapGestureRec)
        
        filtersCell.searchIcon.addTarget(self, action: #selector(handleDataLoading), for: .touchUpInside)
    }
    
    @objc func handleViewTap() {
        topView.searchTextField.resignFirstResponder()
        filtersCell.authorTextField.resignFirstResponder()
        filtersCell.languageTextField.resignFirstResponder()
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}




extension RepositoriesBrowserViewController {
    func handleTableViewDataReloading() {
        repositoriesTableView.reloadData()
    }
    
    func handleDataInitialLoading() {
        pagesLoaded = 1
        MKProgress.show()
        let query = topView.searchTextField.text
        guard let endpoint = buildURL(), let endpointURL = endpoint.url else {
            showAlert(title: self.loadingFailed, message: self.tryAgain, actionLabel: "OK")
            return
        }
        actualEndpoint = endpoint
        
        dataLoader.handleDataLoading(url: endpointURL) { (viewModel, error) in
            MKProgress.hide()
            switch (viewModel, error) {
            case (let newVM, nil) :
                newVM?.query = query
                self.viewModel = newVM
            case ( nil , _):
                self.showAlert(title: self.errorWhileLoading, message: self.checkConnection, actionLabel: self.close)
            case (.some(_), .some(_)):
                self.showAlert(title: self.errorWhileLoading, message: self.checkConnection, actionLabel: self.close)
            }
        }
    }
    
    func handleDataAdding() {
        guard let endpointURL = actualEndpoint?.url else {return}
        
        dataLoader.handleDataLoading(url: endpointURL) { (viewModel, error) in
            switch (viewModel, error) {
            case (let newVM, nil) :
                self.addNewRepositoriesToViewModel(from: newVM)
            default:
                print("Process of adding data finished")
                
            }
        }
    }
    
    private func addNewRepositoriesToViewModel (from newViewModel: RepositoriesViewModel?) {
        guard let newVM  = newViewModel else {return}
        let repositories = newVM.repositories
        self.viewModel?.repositories.append(contentsOf: repositories)
        handleTableViewDataReloading()
    }
    
    //builds Endpoint out of all UI elements
    func buildURL() -> Endpoint?{
        guard let constructor = queryConstructor else {return nil}
        let matching    = constructor.matching
        let sortedBy    = sortOrderConstructor.sortedBy
        let orderBy     = sortOrderConstructor.orderBy
        let endpoint    = Endpoint.search(matching: matching, sortedBy: sortedBy, orderBy: orderBy, page: pagesLoaded)
        return endpoint 
    }
    
    func showAlert(title: String, message:String, actionLabel: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionLabel, style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func makeHapticImpact() {
        feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator?.prepare()
        feedbackGenerator?.impactOccurred()
    }
}



extension RepositoriesBrowserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            return 0
        }
            if tableView == filterTableView {
                switch expandedFiltersView {
                case .hidden:
                    return 0
                case .visible:
                    return 1
                }
            } else if tableView == repositoriesTableView {
                if let delegate = viewModel {
                    if delegate.repositories.count == 0 {
                        //SHOW ALARM HERE
                        tableView.setEmptyView(title: "Run the search above.", message: "Found repositories will be there.")
                    } else {
                        tableView.restore()
                        return delegate.repositories.count
                    }
                } else {
                    tableView.setEmptyView(title: "No data to show.", message: "Run search to let me show you some results.")
                }
            }
        return 0
}
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == repositoriesTableView{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: REPOSITORIES_IDENTIFIER , for: indexPath) as! RepositoryTableViewCell
            if let viewModel = viewModel {
                cell.viewModel = viewModel.repositories[indexPath.row]
            }
            return cell
                } else {
            let cell = filtersCell
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == filterTableView {
            showMoreFilters.addTarget(self, action: #selector(handleExpandHide), for: .touchUpInside)
            return showMoreFilters
        } else if tableView == repositoriesTableView {
            if viewModel != nil {
                tableViewSectionHeader.text = viewModel?.sectionHeader()
            }
            return tableViewSectionHeader
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == repositoriesTableView {
            makeHapticImpact()
            let singleViewModel = viewModel?.repositories[indexPath.row]
            let srvc = SingleRepositoryViewController()
            srvc.viewModel = singleViewModel
            self.navigationController?.pushViewController(srvc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard viewModel != nil else {return}
        //check if this is the last cell that will be displayed
        if isMoreToLoad(row: indexPath.row) {
            pagesLoaded += 1
            actualEndpoint?.changePage(page: pagesLoaded)
            handleDataAdding()
        }
    }
    
    @objc func handleExpandHide() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        switch expandedFiltersView {
        case .visible:
            expandedFiltersView = .hidden
            let indexPath = IndexPath(row: 0, section: 0)
            self.filterTableView.deleteRows(at: [indexPath], with: .fade)
        case .hidden:
            expandedFiltersView = .visible
            let indexPath = IndexPath(row: 0, section: 0)
            self.filterTableView.insertRows(at: [indexPath], with: .fade)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private func isMoreToLoad(row: Int) -> Bool {
        if row == (viewModel!.repositories.count - 1) {
            // check if there is anything left to load
            if (viewModel!.totalCount - viewModel!.repositories.count) > 0 {
                return true
            }
        }
        return false
    }
}

extension RepositoriesBrowserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveSearch()
        handleDataLoading()
        topView.searchTextField.hideResultsList()
        topView.searchTextField.resignFirstResponder()
        topView.searchTextField.text = ""
        return true
    }
    
    fileprivate func saveSearch() {
        
        guard let searchText = topView.searchTextField.text, searchText != "" else {return}
    
        let search = Search(context: PersistenceService.context)
        search.text = searchText
        search.date = Date()
        PersistenceService.saveContext()
        topView.searchTextField.lastSearched =  PersistentServiceHelper.fetchSearches()
    }
    
    @objc func handleDataLoading() {
        guard let searchText = topView.searchTextField.text, searchText != "" else {
            showAlert(title: "Empty field", message: "Please fill the search field", actionLabel: "OK")
            return
        }
        
        if let viewModel = viewModel {
            viewModel.repositories.removeAll()
            viewModel.totalCount = 0
            repositoriesTableView.reloadData()
        }
        handleDataInitialLoading()
        
    }
}


