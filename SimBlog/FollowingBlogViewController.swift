//
//  FollowingBlogViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class FollowingBlogViewController: UIViewController, UITableViewDelegate, BlogCellDelegate {
    @IBOutlet weak var tableView: UITableView!

    let followingBlogViewModel = FollowingBlogViewModel()
    let blogManager = BlogManager.sharedInstance
    var selectedBlog: Blog!
    let currentUser = CurrentUser.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        followingBlogViewModel.didLoad(tableView, viewController: self)
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        navigationItem.rightBarButtonItem("New", target: self, action: #selector
//            (FollowingBlogViewController.modalNewBlog(_:)))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add-blog"), style: .Plain, target: self, action:  #selector
            (FollowingBlogViewController.modalNewBlog(_:)))

        
        followingBlogViewModel.willAppear()
    }
    
    override func viewDidAppear(animated: Bool) {
//        su
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK - TableView Delagate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return 50
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let showBlogVC = UIStoryboard.viewControllerWith("Blog", identifier: "ShowBlogViewController") as! ShowBlogViewController
            showBlogVC.blog = currentUser.followingBlogAtPosition(indexPath.row)
            self.navigationController?.pushViewController(showBlogVC, animated: true)
        } else if indexPath.section == 1 {
            followingBlogViewModel.loadMoreItems()
        }
    }
    
    func modalNewBlog(sender: UIBarButtonItem) {
        let newBlogNC = UIStoryboard.viewControllerWith("Blog", identifier: "NewBlogNavigationController")
        presentViewController(newBlogNC, animated: true, completion: nil)
        
    }
    
    func didTapProfileImageView(blog: Blog) {
        let showUserVC = UIStoryboard.viewControllerWith("User", identifier: "ShowUserViewController") as! ShowUserViewController
        showUserVC.selectedUser = blog.user
        navigationController?.pushViewController(showUserVC, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
