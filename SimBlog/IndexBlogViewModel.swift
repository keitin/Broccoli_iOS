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
    
    func didLoad(tableView: UITableView, viewController: IndexBlogViewController) {
        blogManager.getBlogsInbackgroundWithBlock(user: nil) { 
            self.insertTopRow(tableView)
        }
        self.viewController = viewController
        self.tableView = tableView
        tableView.dataSource = self
        tableView.registerCell("BlogCell")
    }
    
    func willAppear() {
        insertTopRow(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogManager.numberOfBlogs
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BlogCell", forIndexPath: indexPath) as! BlogCell
        cell.fillWith(blogManager.blogAtPosition(indexPath.row))
        cell.delegate = viewController
        return cell
    }
    
    
    // MARK Table View Private
    private func insertTopRow(tableView: UITableView) {
        let differenceIndex = blogManager.numberOfBlogs - tableView.numberOfRowsInSection(0)
        if differenceIndex > 0 {
            for _ in 1...differenceIndex {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
            }
        }
    }
    
}
