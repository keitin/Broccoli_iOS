//
//  ShowBlogViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class ShowBlogViewModel: NSObject, UITableViewDataSource {
    
    var tableView: UITableView!
    var blog: Blog!
    var displayTitleCell: DisplayTitleCell!
    
    func didLoad(blog: Blog, tableView: UITableView) {
        self.blog = blog
        self.tableView = tableView
        self.tableView.registerCell("DisplayTextCell")
        self.tableView.registerCell("DisplayImageCell")
        self.tableView.registerCell("DisplayTitleCell")
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100000
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.blog.findMaterialsInBackground {
            tableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return blog.numberOfMaterials
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DisplayTitleCell", forIndexPath: indexPath) as! DisplayTitleCell
            cell.fillWith(blog)
            self.displayTitleCell = cell
            return cell
        } else {
            if let blogImage = blog.materialAtPosition(indexPath.row) as? BlogImage {
                let cell = tableView.dequeueReusableCellWithIdentifier("DisplayImageCell", forIndexPath: indexPath) as! DisplayImageCell
                cell.fillWith(blogImage)
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("DisplayTextCell", forIndexPath: indexPath) as! DisplayTextCell
                let blogText = blog.materialAtPosition(indexPath.row) as! BlogText
                cell.fillWith(blogText)
                return cell
            }
        }
        
    }
    
}
