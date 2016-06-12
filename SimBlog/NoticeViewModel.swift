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
    weak var viewController: NoticeViewController!
    let currentUser = CurrentUser.sharedInstance
    var page = 1
    
    func didLoad(tableView: UITableView, viewController: NoticeViewController) {
        self.viewController = viewController
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.registerCell("NoticeCell")
        self.tableView.registerCell("MoreItemsCell")
    }
    
    func willLoad() {
        getNoticesInBackground(currentUser, page: self.page) {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return currentUser.numberOfNotices
        } else {
            return 1
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NoticeCell", forIndexPath: indexPath) as! NoticeCell
            cell.delegate = viewController
            cell.fillwith(currentUser.notices[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("MoreItemsCell", forIndexPath: indexPath) as! MoreItemsCell
            return cell
        }
    }
    
    func loadMoreItems() {
        page = page + 1
        getNoticesInBackground(currentUser, page: self.page) {
            self.insertTopRow(self.tableView)
        }
    }
    
    private func insertTopRow(tableView: UITableView) {
        let differenceIndex = currentUser.numberOfNotices - tableView.numberOfRowsInSection(0)
        if differenceIndex > 0 {
            for _ in 1...differenceIndex {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: currentUser.numberOfNotices - 1, inSection: 0)], withRowAnimation: .None)
            }
        }
    }

}
