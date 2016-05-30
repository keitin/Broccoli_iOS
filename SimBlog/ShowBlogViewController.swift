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
    let showBlogViewModel = ShowBlogViewModel()
    var blog: Blog!
    var loveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        showBlogViewModel.didLoad(blog, tableView: tableView)
        
        isLike(self.blog) { (isLike) in
            self.loveButton = self.navigationItem.loveButtonItem(self, action: #selector(ShowBlogViewController.didTapLoveButton(_:)), selected: isLike)
            self.navigationItem.rightBarButtonItem = self.loveButton
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
    
    //MARK: Like Action
    func didTapLoveButton(sender: UIButton) {
        if sender.selected {
            unLikeBlog(sender)
        } else {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
