//
//  ShowBlogViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import Bond

class ShowBlogViewController: UIViewController, DisplayTitleCellDelegate, Like, Report {
    
    @IBOutlet weak var tableView: UITableView!
    let showBlogViewModel = ShowBlogViewModel()
    var blog: Blog!
    var loveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        showBlogViewModel.didLoad(blog, tableView: tableView)
        
        var barItems: [UIBarButtonItem] = []
        
        isLike(self.blog) { (isLike) in
            self.loveButton = self.navigationItem.loveButtonItem(self, action: #selector(ShowBlogViewController.didTapLoveButton(_:)), selected: isLike)
                barItems.insert(self.loveButton, atIndex: 0)
            let menu = UIBarButtonItem(title: "…", style: .Done, target: self, action: #selector(ShowBlogViewController.tapActionSheet(_:)))
                barItems.insert(menu, atIndex: 0)
            self.navigationItem.rightBarButtonItems = barItems
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        showBlogViewModel.displayTitleCell.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapProfileImageView(blog: Blog) {
        let showUserVC = UIStoryboard.viewControllerWith("User", identifier: "ShowUserViewController") as! ShowUserViewController
        showUserVC.selectedUser = blog.user
        navigationController?.pushViewController(showUserVC, animated: true)
    }
    
    func didTappedCommentButton() {
        let commentIndexVC = UIStoryboard.viewControllerWith("Comment", identifier: "IndexCommentViewController") as! IndexCommentViewController
        commentIndexVC.blog = self.blog
        commentIndexVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(commentIndexVC, animated: true)
    }
    
    //MARK: Like Action
    func didTapLoveButton(sender: UIButton) {
        if sender.selected {
            unLikeBlog(sender)
        } else {
            sender.animateWithLove()
            likeBlog(sender)
        }
    }
    
    private func likeBlog(button: UIButton) {
        likeInBackground(blog) {
            button.selected = true
            self.blog.likesCount.value = Int(self.blog.likesCount.value) + 1
        }
    }
    
    private func unLikeBlog(button: UIButton) {
        deleteLikeInBackground(blog) {
            button.selected = false
            self.blog.likesCount.value = self.blog.likesCount.value - 1
        }
    }
    
    func tapActionSheet(sender: UIBarButtonItem) {
        let sheet = UIAlertController.actionSheet("", message: "")
        let reportAction = UIAlertAction(title: Message.report, style: .Default) { (action) in
            let selectReport = UIAlertController.reportSelectAction({ (reportType) in
                self.reportUser(self.blog.user, blog: self.blog, reportType: reportType, callback: { (message) in
                    let okAlert = UIAlertController.okAlertWithMessage(message)
                    self.presentViewController(okAlert, animated: true, completion: nil)
                })
            })
            self.presentViewController(selectReport, animated: true, completion: nil)
        }
        
        if CurrentUser.sharedInstance.id == blog.user.id {
            let deleteAction = UIAlertAction(title: Message.deleteBlog, style: .Default) { (action) in
                self.blog.deleteBlogInBackground({
                    
                    if let followingVC = self.navigationController?.previousViewController() as? FollowingBlogViewController {
                        followingVC.followingBlogViewModel.refershData({
                            self.navigationController?.popViewControllerAnimated(true)
                        })
                    } else {
                        let showUserVC = self.navigationController?.previousViewController() as! ShowUserViewController
                        showUserVC.showUserViewModel.reloadItems {
                            self.navigationController?.popViewControllerAnimated(true)
                        }
                    }
                })
            }
            sheet.addAction(deleteAction)
        }
        
        sheet.addAction(reportAction)
        self.presentViewController(sheet, animated: true, completion: nil)
    }
}
