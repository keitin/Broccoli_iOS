//
//  ShowBlogViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import Bond

class ShowBlogViewController: UIViewController, DisplayTitleCellDelegate, Like {
    

    @IBOutlet weak var tableView: UITableView!
    var blog: Blog!
    let showBlogViewModel = ShowBlogViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showBlogViewModel.didLoad(blog, tableView: tableView, viewController: self)
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
    
    //MARK: Like Action
    func didTapLikeButton(button: UIButton, blog: Blog) {
        likeInBackground(blog) { 
            button.selected = true
            blog.likesCount.value = Int(blog.likesCount.value) + 1
        }
    }
    
    func didTapUnLikeButton(button: UIButton, blog: Blog) {
        deleteLikeInBackground(blog) {
            button.selected = false
            blog.likesCount.value = blog.likesCount.value - 1
        }
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
