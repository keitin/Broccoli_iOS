//
//  NoticeViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/14.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class NoticeViewModel: NSObject, UITableViewDataSource, NoticeType {

    var tableView: UITableView!
    var viewController: NoticeViewController!
    let currentUser = CurrentUser.sharedInstance
    
    func didLoad(tableView: UITableView, viewController: NoticeViewController) {
        self.viewController = viewController
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.registerCell("NoticeCell")
    }
    
    func willLoad() {
        getNoticesInBackground(currentUser) {
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUser.numberOfNotices
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoticeCell", forIndexPath: indexPath) as! NoticeCell
        cell.delegate = viewController
        cell.fillwith(currentUser.notices[indexPath.row])
        return cell
    }

}
