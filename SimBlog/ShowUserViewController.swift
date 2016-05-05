//
//  ShowUserViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/04.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class ShowUserViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let showUserViewModel = ShowUserViewModel()
    let currentUser = CurrentUser.sharedInstance
    var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MY PAGE"
        let user = selectedUser ?? currentUser
        showUserViewModel.didLoad(tableView, user: user)
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
            return 165
        } else {
            return 50
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            let showBlogVC = UIStoryboard.viewControllerWith("Main", identifier: "ShowBlogViewController") as! ShowBlogViewController
            let user = selectedUser ?? currentUser
            showBlogVC.blog = user.blogAtPosition(indexPath.row)
            self.navigationController?.pushViewController(showBlogVC, animated: true)
        } else if indexPath.section == 2 {
            showUserViewModel.loadMoreItems()
        }
        
    }
}
