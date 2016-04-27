//
//  NewBlogViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class NewBlogViewModel: NSObject, UITableViewDataSource, TextCellDelegate {
    
    let blog = Blog()
    var tableView: UITableView!
    var activeTextView: UITextView?
    
    override init() {
        super.init()
    }
    
    func didLoad(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.registerCell("TextCell")
        self.tableView.registerCell("ImageCell")
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100000
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    //MARK Table View Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return blog.numberOfMaterials
        return blog.numberOfMaterials
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let _ = blog.materialAtPosition(indexPath.row) as? BlogImage {
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) as! TextCell
            let blogText = blog.materialAtPosition(indexPath.row) as? BlogText
            cell.textView.tag = indexPath.row
            cell.textView.text = blogText?.text
            cell.delegate = self
            return cell
        }
    }
    
    //MARK - TextView Delegate
    func textViewDidChange(textView: UITextView) {
        
        if let blogText = blog.materialAtPosition(textView.tag) as? BlogText {
            blogText.text = textView.text
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.activeTextView = textView
    }
    
    //MARK - Tool Button Action
    func addText() {
        blog.addTextAtPosition("", index: blog.numberOfMaterials)
        insertBottomRow(tableView)
        let indexPath = NSIndexPath(forRow: blog.numberOfMaterials - 1, inSection: 0)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    func addImage() {
        blog.addImageAtPostion(UIImage(named: "image.jpg")!, index: blog.numberOfMaterials)
        insertBottomRow(tableView)
        let indexPath = NSIndexPath(forRow: blog.numberOfMaterials - 1, inSection: 0)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    func didFinishedEdit() {
        if let textView = self.activeTextView {
            textView.endEditing(true)
        }
    }
    
    // MARK Table View Provate
    private func insertBottomRow(tableView: UITableView) {
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: blog.numberOfMaterials - 1, inSection: 0)], withRowAnimation: .None)
    }
}
