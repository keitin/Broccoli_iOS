//
//  NewBlogViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SVProgressHUD

class NewBlogViewModel: NSObject, UITableViewDataSource, TextCellDelegate, TitleCellDelegate {
    
    let blog = Blog()
    let blogManeger = BlogManager.sharedInstance
    var tableView: UITableView!
    var activeTextView: UITextView?
    let currentUser = CurrentUser.sharedInstance
    
    override init() {
        super.init()
    }
    
    func didLoad(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.registerCell("TextCell")
        self.tableView.registerCell("ImageCell")
        self.tableView.registerCell("TitleCell")
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100000
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    //MARK Table View Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return blog.numberOfMaterials
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
            cell.delegate = self
            cell.fillWith(blog)
            return cell
        } else {
            if let _ = blog.materialAtPosition(indexPath.row) as? BlogImage {
                let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
                let blogImage = blog.materialAtPosition(indexPath.row) as! BlogImage
                cell.blogImageView.image = blogImage.image
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
    }
    
    //MARK - TextView Delegate
    func textViewDidChange(textView: UITextView) {
        if textView.tag == 0 {
            blog.sentence = textView.text
        }
        if let blogText = blog.materialAtPosition(textView.tag) as? BlogText {
            blogText.text = textView.text
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.activeTextView = textView
    }
    
    func titleTextViewDidChange(textView: UITextView) {
        blog.title = textView.text
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func titleTextViewDidBeginEditing(textView: UITextView) {
        
    }
    
    //MARK - Tool Button Action
    func addText() {
        blog.addTextAtPosition("", index: blog.numberOfMaterials)
        insertBottomRow(tableView)
        let indexPath = NSIndexPath(forRow: blog.numberOfMaterials - 1, inSection: 1)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    func addImage(image: UIImage) {
        blog.addImageAtPosition(image, index: blog.numberOfMaterials)
        insertBottomRow(tableView)
        let indexPath = NSIndexPath(forRow: blog.numberOfMaterials - 1, inSection: 1)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        if let _ = blog.topImage { return }
        blog.topImage = image
    }
    
    func didFinishedEdit() {
        if let textView = self.activeTextView {
            textView.endEditing(true)
        }
    }
    
    func postBlog(callback: (message: String?) -> Void) {
        if blog.title == "" || blog.topImage == nil {
            callback(message: ErrorMessage.emptyTitleOrImage())
            return
        }
        SVProgressHUD.show()
        blog.saveInbackground {
            SVProgressHUD.dismiss()
            self.blogManeger.addBlogAtPosition(self.blog, index: 0)
            self.currentUser.addBlogAtPosition(self.blog, index: 0)
            callback(message: nil)
        }        
    }
    
    // MARK Table View Private
    private func insertBottomRow(tableView: UITableView) {
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: blog.numberOfMaterials - 1, inSection: 1)], withRowAnimation: .Fade)
    }
}
