//
//  SearchResultsBlogViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/11.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class SearchResultsBlogViewModel: NSObject, UITableViewDataSource {
    
    var tableView: UITableView!
    weak var viewController: SearchBlogViewController!
    let blogManager = BlogManager.sharedInstance
    var page = 1
    var currentKeyword: String!
    
    func didLoad(tableView: UITableView, viewController: SearchBlogViewController) {
        self.viewController = viewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.registerCell("BlogCell")
        tableView.registerCell("MoreItemsCell")
    }
    
    func willAppear() {
        insertNewBlogToRow(tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return blogManager.numberOfSearchBlogs
        } else {
            return 1
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("BlogCell", forIndexPath: indexPath) as! BlogCell
            cell.fillWith(blogManager.searchBlogs[indexPath.row])
            cell.delegate = viewController
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("MoreItemsCell", forIndexPath: indexPath) as! MoreItemsCell
            return cell
        }
    }
    
    func searchBlogs(keyword: String, callback: () -> Void) {
        self.currentKeyword = keyword
        blogManager.searchBlogsInBackground(currentKeyword, page: page) {
            self.tableView.reloadData()
            callback()
        }
    }
    
    func loadMoreItems() {
        page = page + 1
        blogManager.searchBlogsInBackground(currentKeyword, page: page) {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK Table View Private
    private func insertTopRow(tableView: UITableView) {
        let differenceIndex = blogManager.numberOfBlogs - tableView.numberOfRowsInSection(0)
        if differenceIndex > 0 {
            for _ in 1...differenceIndex {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: blogManager.numberOfBlogs - 1, inSection: 0)], withRowAnimation: .Fade)
            }
        }
    }
    
    private func insertNewBlogToRow(tableView: UITableView) {
        let differenceIndex = blogManager.numberOfBlogs - tableView.numberOfRowsInSection(0)
        if differenceIndex > 0 {
            for _ in 1...differenceIndex {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
            }
        }
    }

}
