//
//  ShowUserViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/04.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class ShowUserViewModel: NSObject, UITableViewDataSource {
    
    var tableView: UITableView!
    var viewController: ShowUserViewController!
    let currentUser = CurrentUser.sharedInstance
    var selectedUser: User!
    var page = 1
    var isFollow = false
    
    func didLoad(viewController: ShowUserViewController, tableView: UITableView, user: User) {
        self.viewController = viewController
        self.tableView = tableView
        self.selectedUser = user
        self.selectedUser.getBlogsInBackground(page) {
            tableView.reloadData()
        }
        tableView.dataSource = self
        tableView.registerCell("ProfileCell")
        tableView.registerCell("BlogCell")
        tableView.registerCell("MoreItemsCell")
    }
    
    func willAppear() {
        insertNewBlogToRow(tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return selectedUser.numberOfBlogs
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
            cell.delegate = viewController
            cell.fillWith(selectedUser)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("BlogCell", forIndexPath: indexPath) as! BlogCell
            cell.fillWith(selectedUser.blogAtPosition(indexPath.row))
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("MoreItemsCell", forIndexPath: indexPath) as! MoreItemsCell
            return cell
        }
    }
    
    func loadMoreItems() {
        page = page + 1
        self.selectedUser.getBlogsInBackground(page) {
            self.insertTopRow(self.tableView)
        }
    }
    
    // MARK Table View Private
    private func insertTopRow(tableView: UITableView) {
        let differenceIndex = selectedUser.numberOfBlogs - tableView.numberOfRowsInSection(1)
        if differenceIndex > 0 {
            for _ in 1...differenceIndex {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: selectedUser.numberOfBlogs - 1, inSection: 1)], withRowAnimation: .Fade)
            }
        }
    }
    
    private func insertNewBlogToRow(tableView: UITableView) {
        let differenceIndex = selectedUser.numberOfBlogs - tableView.numberOfRowsInSection(1)
        if differenceIndex > 0 {
            for _ in 1...differenceIndex {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 1)], withRowAnimation: .Fade)
            }
        }
    }

}
