//
//  ShowUserViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/04.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import Bond
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class ShowUserViewController: UIViewController, UITableViewDelegate, ProfileCellDelegate, Follow, Report, Block {
    
    @IBOutlet weak var tableView: UITableView!
    let showUserViewModel = ShowUserViewModel()
    let currentUser = CurrentUser.sharedInstance
    var selectedUser: User?
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = selectedUser ?? currentUser
        showUserViewModel.didLoad(self, tableView: tableView, user: user)
        tableView.delegate = self
        
        self.refreshControl = UIRefreshControl.loadingItems(self, selector: #selector(ShowUserViewController.pullAndReload))
        self.tableView.addSubview(self.refreshControl)
        
        user.blocking.observe { (block) in
            if block {
                self.title = "ブロック中"
            } else {
                self.title = ""
            }
        }
        
        if user.id == currentUser.id {
            title = "profile"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        showUserViewModel.willAppear()
        if let selectedUser = selectedUser {
            if selectedUser.id == self.currentUser.id { return }
            self.navigationItem.rightBarButtonItem("…", target: self, action: #selector(ShowUserViewController.tapActionSheet(_:)))
        } else {
            self.navigationItem.rightBarButtonItem("…", target: self, action: #selector(ShowUserViewController.showCurrentUserActionSheet(_:)))
        }
        let user = selectedUser ?? currentUser
        self.isBlock(currentUser, toUser: user) { (isBlocked, isBlocking) in
            if isBlocked {
                self.selectedUser?.blocked = true
                self.showUserViewModel.makeBlockedState()
            }
            if isBlocking {
                self.title = "ブロック中"
                self.selectedUser?.blocking.value = true
                self.showUserViewModel.makeBlockingState()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - TableView Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        } else if indexPath.section == 1 {
            return 150
        } else {
            return 50
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            let showBlogVC = UIStoryboard.viewControllerWith("Blog", identifier: "ShowBlogViewController") as! ShowBlogViewController
            let user = selectedUser ?? currentUser
            showBlogVC.blog = user.blogAtPosition(indexPath.row)
            self.navigationController?.pushViewController(showBlogVC, animated: true)
        } else if indexPath.section == 2 {
            showUserViewModel.loadMoreItems(tableView)
        }
    }
    
    //MARK - Profile Cell Delegate
    func didTappedFollowButton(button: UIButton) {
        let user = selectedUser ?? currentUser
        if button.selected == false {
            follow(currentUser, toUser: user) {
                button.selected = true
            }
        } else {
            unfollow(currentUser, toUser: user) {
                button.selected = false
            }
        }
    }
    
    func didTappedFollowerButton(button: UIButton) {
        let indexUserVC = UIStoryboard.viewControllerWith("User", identifier: "IndexUserViewController") as! IndexUserViewController
        indexUserVC.displayType = DisplayType.Followers
        indexUserVC.user = selectedUser ?? currentUser
        navigationController?.pushViewController(indexUserVC, animated: true)
        
    }
    
    func didTappedFollowingButton(button: UIButton) {
        let indexUserVC = UIStoryboard.viewControllerWith("User", identifier: "IndexUserViewController") as! IndexUserViewController
        indexUserVC.displayType = DisplayType.Follows
        indexUserVC.user = selectedUser ?? currentUser
        navigationController?.pushViewController(indexUserVC, animated: true)
    }
    
    //MARK Refesh Control Data
    func pullAndReload() {
        self.showUserViewModel.reloadItems(tableView) {
            self.refreshControl.endRefreshing()
        }
    }
    
    //MARK - Navigation Actions
    func tapActionSheet(sender: UINavigationItem) {
        let sheet = UIAlertController.actionSheet("", message: "")
        let reportAction = UIAlertAction(title: Message.report, style: .Default) { (action) in
            let selectReport = UIAlertController.reportSelectAction({ (reportType) in
                self.reportUser(self.selectedUser!, blog: nil, reportType: reportType, callback: { (message) in
                    let okAlert = UIAlertController.okAlertWithMessage(message)
                    self.presentViewController(okAlert, animated: true, completion: nil)
                })
            })
            self.presentViewController(selectReport, animated: true, completion: nil)
        }

        let blockAction = UIAlertAction.blockAction(self.selectedUser!.blocking.value) {
            let confirmAlet = UIAlertController.confirmBlock(self.selectedUser!.blocking.value, callback: { (block) in
                
                
                if self.selectedUser!.blocking.value {
                    //ブロック解除
                    self.removeBlock(self.currentUser, toUser: self.selectedUser!, callback: {
                        self.selectedUser?.blocking.value = false
                        let okAlert = UIAlertController.okAlertWithMessage("完了しました")
                        self.presentViewController(okAlert, animated: true, completion: nil)
                        self.showUserViewModel.makeRemoveBlockState()
                    })
                } else {
                    //ブロック
                    self.block(self.currentUser, toUser: self.selectedUser!, callback: {
                        self.selectedUser?.blocking.value = true
                        let okAlert = UIAlertController.okAlertWithMessage("完了しました")
                        self.presentViewController(okAlert, animated: true, completion: nil)
                        self.showUserViewModel.makeBlockingState()
                    })
                }
            })
            self.presentViewController(confirmAlet, animated: true, completion: nil)
        }
        
        sheet.addAction(reportAction)
        sheet.addAction(blockAction)
        self.presentViewController(sheet, animated: true, completion: nil)
    }
    
    func showCurrentUserActionSheet(sender: UINavigationItem) {
        let sheet = UIAlertController.actionSheet("", message: "")
        let logoutAction = UIAlertAction(title: "ログアウト", style: .Default) { (action) in
            self.currentUser.deleteUserInLocal()
            FBSDKLoginManager().logOut()
            UIApplication.redirectToLoginViewController()
        }
        sheet.addAction(logoutAction)
        self.presentViewController(sheet, animated: true, completion: nil)
    }
    
    
}
