//
//  IndexCommentViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/07/06.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class IndexCommentViewModel: NSObject, UITableViewDataSource {
    
    weak var blog: Blog!
    weak var tableView: UITableView!
    
    func didLoad(blog: Blog, tableView: UITableView) {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerCell("CommentCell")
        self.tableView = tableView
        
        self.blog = blog
        self.blog.getCommentsInBackground { 
            self.tableView.reloadData()
        }
    }
    
    //MARK: Table View Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blog.comments.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentCell
        cell.fillWith(self.blog.comments[indexPath.row])
        return cell
    }
    
    func postComment(blog: Blog, text: String) {
        
        if text.isEmpty { return }
        
        let currentUser = CurrentUser.sharedInstance
        let comment = Comment(text: text, user: currentUser)
        comment.saveInBackground(blog) { 
            self.tableView.reloadData()
            blog.commentsCount.value = Int(blog.commentsCount.value) + 1
        }
    }

    
}
