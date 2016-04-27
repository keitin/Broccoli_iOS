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
    let blogManager = BlogManager.sharedInstance
    
    func didLoad(tableView: UITableView) {
        self.tableView = tableView
        tableView.dataSource = self
        tableView.registerCell("BlogCell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogManager.numberOfBlogs
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BlogCell", forIndexPath: indexPath) as! BlogCell
        return cell
    }
    
}
