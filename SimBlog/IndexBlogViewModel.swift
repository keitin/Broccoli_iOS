//
//  IndexBlogViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class IndexBlogViewModel: NSObject, UITableViewDataSource {
    
    var tableView: UITableView!
    var viewController: IndexBlogViewController!
    let blogManager = BlogManager.sharedInstance
    var page = 1
    
    func didLoad(tableView: UITableView, viewController: IndexBlogViewController) {
        blogManager.getBlogsInbackgroundWithBlock(user: nil, page: page) {
            self.insertTopRow(tableView)
        }
        self.viewController = viewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.registerCell("BlogCell")
        tableView.registerCell("MoreItemsCell")
    }
    
    func willAppear() {
        insertTopRow(tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return blogManager.numberOfBlogs
        } else {
            return 1
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("BlogCell", forIndexPath: indexPath) as! BlogCell
            cell.fillWith(blogManager.blogAtPosition(indexPath.row))
            cell.delegate = viewController
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("MoreItemsCell", forIndexPath: indexPath) as! MoreItemsCell
            return cell
        }
        
    }
    
    func loadMoreItems() {
        page = page + 1
        blogManager.getBlogsInbackgroundWithBlock(user: nil, page: page) { 
            self.insertTopRow(self.tableView)
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
    
}
