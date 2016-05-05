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
    let currentUser = CurrentUser.sharedInstance
    var selectedUser: User!
    
    func didLoad(tableView: UITableView, user: User) {
        self.tableView = tableView
        self.selectedUser = user
        self.selectedUser.getBlogsInBackground { 
            self.insertTopRow(tableView)
        }
        tableView.dataSource = self
        tableView.registerCell("ProfileCell")
        tableView.registerCell("BlogCell")
    }
    
    func willAppear() {
        insertTopRow(tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return selectedUser.numberOfBlogs
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
            cell.fillWith(selectedUser)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("BlogCell", forIndexPath: indexPath) as! BlogCell
            cell.fillWith(selectedUser.blogAtPosition(indexPath.row))
            return cell
        }
    }
    
    // MARK Table View Private
    private func insertTopRow(tableView: UITableView) {
        let differenceIndex = selectedUser.numberOfBlogs - tableView.numberOfRowsInSection(1)
        if differenceIndex > 0 {
            for _ in 1...differenceIndex {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 1)], withRowAnimation: .Fade)
            }
        }
    }
}
