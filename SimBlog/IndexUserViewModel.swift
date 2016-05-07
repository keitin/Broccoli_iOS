//
//  FollowViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/07.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class IndexUserViewModel: NSObject, UITableViewDataSource {
    
    var user: User!
    var tableView: UITableView!
    var displayType: DisplayType!
    
    func didLoad(tableView: UITableView, user: User, displayType: DisplayType) {
        self.tableView = tableView
        self.displayType = displayType
        self.user = user
        tableView.dataSource = self
        tableView.registerCell("UserCell")
        if displayType == .Follows {
            user.getFollowsInBackground { self.insertTopRow(self.tableView) }
        } else {
            user.getFollowersInBackground { self.insertTopRow(self.tableView) }
        }
        
    }
    
    //MARK - TableView Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if displayType == .Follows {
            return user.numberOfFollows
        } else {
            return user.numberOfFollowers
        }   
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        if displayType == .Follows {
            cell.fillWith(user.follows[indexPath.row])
        } else {
            cell.fillWith(user.followers[indexPath.row])
        }
        return cell
    }
    
    // MARK Table View Private
    private func insertTopRow(tableView: UITableView) {
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
    }
}
