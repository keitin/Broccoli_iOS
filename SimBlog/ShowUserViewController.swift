//
//  ShowUserViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/04.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class ShowUserViewController: UIViewController, UITableViewDelegate, ProfileCellDelegate, Follow {
    
    @IBOutlet weak var tableView: UITableView!
    let showUserViewModel = ShowUserViewModel()
    let currentUser = CurrentUser.sharedInstance
    var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = selectedUser ?? currentUser
        showUserViewModel.didLoad(self, tableView: tableView, user: user)
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        showUserViewModel.willAppear()
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
            showUserViewModel.loadMoreItems()
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
}
