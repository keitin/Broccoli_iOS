//
//  SearchBlogViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class SearchBlogViewModel: NSObject, UITableViewDataSource {
    
    var tableView: UITableView!
    let seachHistory = SearchHistory()
    
    func didLoad(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.registerCell("SearchHistoryCell")
        self.tableView.registerCell("DeleteHistoryCell")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return seachHistory.numberOfTexts
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DeleteHistoryCell", forIndexPath: indexPath) as! DeleteHistoryCell
            cell.deleteHistoryButton.addTarget(self, action: #selector(SearchBlogViewModel.tapDeleteHistoryButton(_:)), forControlEvents: .TouchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("SearchHistoryCell", forIndexPath: indexPath) as! SearchHistoryCell
            cell.hisoryTitleLabel.text = seachHistory.textAtPosition(indexPath.row)
            return cell
        }
    }
    
    func searchTextFieldShouldReturn(textFiled: UITextField) {
        
    }
    
    func tapDeleteHistoryButton(sender: UIButton) {
        seachHistory.deleteinLocal()
        tableView.reloadData()
    }
}
