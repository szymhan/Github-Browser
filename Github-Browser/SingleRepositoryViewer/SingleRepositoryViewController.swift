//
//  SingleRepositoryViewController.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 21/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit
import MarkdownKit

class SingleRepositoryViewController: UIViewController {
    
    var viewModel: RepositoryViewModel? {
        didSet {
            fillUI()
        }
    }
    
    let repositoryView = SingleRepositoryView()
    let dataLoader = DataLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(repositoryView)
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        setUI()
        addGestureRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func setUI() {
        repositoryView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}

extension SingleRepositoryViewController {
    
    func fillUI() {
        repositoryView.viewModel = viewModel
        self.navigationItem.title = viewModel?.repositoryName
        let readmeText = dataLoader.getReadme(repoName: viewModel!.repositoryName, ownerName:viewModel!.userName )
        let markDownParser = MarkdownParser()
        repositoryView.readme.attributedText = markDownParser.parse(readmeText)
    }
    
    func addGestureRecognizers() {
        repositoryView.copyToClipboard.addTarget(self, action: #selector(handleCopyToClipboard), for: .touchUpInside)
    }
    
    @objc private func handleCopyToClipboard() {
        UIPasteboard.general.string = viewModel?.htmlURL
    }
    
    private func makeBackButton() -> UIButton {
        let backButton = UIButton(type: .custom)
        backButton.tintColor = .lighteriPhoneBlue
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.iphoneBlue, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    @objc private func backButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
        //dismiss(animated: true, completion: nil)
        //        navigationController?.popViewController(animated: true)
    }

}