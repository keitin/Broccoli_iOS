//
//  IndexCommentViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/07/06.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class IndexCommentViewModel: NSObject, UITableViewDataSource {
    
    let texts = ["hogehoge", "hogehogehogehogehgoehogeghoeghoehgoehgoehogheoghgeoehgeo"]
    
    func didLoad(tableView: UITableView) {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerCell("CommentCell")
    }
    
    //MARK: Table View Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentCell
        cell.commentLabel.text = self.texts[indexPath.row]
        return cell
    }
    
}
