//
//  RepositoryViewModelTests.swift
//  Github-BrowserTests
//
//  Created by Hanzel, Szymon on 24/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import XCTest

@testable import Github_Browser

class RepositoryViewModelTests: XCTestCase {

         let invalidRepository = Repository(id: 12, nodeID: nil, name: "name", fullName: "fullName", itemPrivate: false, owner: Owner(login: "login", id: 1, nodeID: nil, avatarURL: nil, gravatarID: nil, url: nil, htmlURL: nil, followersURL: nil, followingURL: nil, gistsURL: nil, starredURL: nil, subscriptionsURL: nil, organizationsURL: nil, reposURL: nil, eventsURL: nil, receivedEventsURL: nil, type: nil, siteAdmin: nil), htmlURL: "https://github.com/example/example/", itemDescription: nil, fork: nil, url: nil, forksURL: nil, keysURL: nil, collaboratorsURL: nil, teamsURL: nil, hooksURL: nil, issueEventsURL: nil, eventsURL: nil, assigneesURL: nil, branchesURL: nil, tagsURL: nil, blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil, treesURL: nil, statusesURL: nil, languagesURL:nil , stargazersURL: nil, contributorsURL: nil, subscribersURL: nil, subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil, commentsURL: nil, issueCommentURL: nil, contentsURL: nil, compareURL: nil, mergesURL: nil, archiveURL: nil, downloadsURL: nil, issuesURL: nil, pullsURL: nil, milestonesURL: nil, notificationsURL: nil, labelsURL: nil, releasesURL: nil, deploymentsURL: nil, createdAt: Date(), updatedAt: Date(), pushedAt: nil, gitURL: nil, sshURL: nil, cloneURL: nil, svnURL: nil, homepage: nil, size: 0, stargazersCount: 12, watchersCount: 12, language: nil, hasIssues: nil, hasProjects: nil, hasDownloads: nil, hasWiki: nil, hasPages: nil, forksCount: 12, mirrorURL: nil, archived: nil, disabled: nil, openIssuesCount: nil, license: nil, forks: 12, openIssues: 0, watchers: 12, defaultBranch: nil, score: 93)
    
    let validRepository = Repository(id: 12, nodeID: nil, name: "name", fullName: "fullName", itemPrivate: false, owner: Owner(login: "login", id: 1, nodeID: nil, avatarURL: "https://github.com/example/example/", gravatarID: nil, url: nil, htmlURL: nil, followersURL: nil, followingURL: nil, gistsURL: nil, starredURL: nil, subscriptionsURL: nil, organizationsURL: nil, reposURL: nil, eventsURL: nil, receivedEventsURL: nil, type: nil, siteAdmin: nil), htmlURL: "https://github.com/example/example/", itemDescription: nil, fork: nil, url: nil, forksURL: nil, keysURL: nil, collaboratorsURL: nil, teamsURL: nil, hooksURL: nil, issueEventsURL: nil, eventsURL: nil, assigneesURL: nil, branchesURL: nil, tagsURL: nil, blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil, treesURL: nil, statusesURL: nil, languagesURL:nil , stargazersURL: nil, contributorsURL: nil, subscribersURL: nil, subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil, commentsURL: nil, issueCommentURL: nil, contentsURL: nil, compareURL: nil, mergesURL: nil, archiveURL: nil, downloadsURL: nil, issuesURL: nil, pullsURL: nil, milestonesURL: nil, notificationsURL: nil, labelsURL: nil, releasesURL: nil, deploymentsURL: nil, createdAt: Date(), updatedAt: Date(), pushedAt: nil, gitURL: nil, sshURL: nil, cloneURL: nil, svnURL: nil, homepage: nil, size: 0, stargazersCount: 12, watchersCount: 12, language: nil, hasIssues: nil, hasProjects: nil, hasDownloads: nil, hasWiki: nil, hasPages: nil, forksCount: 12, mirrorURL: nil, archived: nil, disabled: nil, openIssuesCount: nil, license: nil, forks: 12, openIssues: 0, watchers: 12, defaultBranch: nil, score: 93)
    
    
    override func setUp() {}
    
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidRepositoryViewModel() {
        let viewModel = RepositoryViewModelForTableView(withRepository: validRepository)
        
        XCTAssertNotNil(viewModel)
        
    }
    
    func testinvalidRepositoryViewModel() {
        let viewModel = RepositoryViewModelForTableView(withRepository: invalidRepository)
        
        XCTAssertNil(viewModel)
        
    }
    

}
