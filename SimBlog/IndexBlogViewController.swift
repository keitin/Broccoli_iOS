//
//  BlogListViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class IndexBlogViewController: UIViewController, UITableViewDelegate, BlogCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    let indexBlogViewModel = IndexBlogViewModel()
    let blogManager = BlogManager.sharedInstance
    var selectedBlog: Blog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Blog"
        indexBlogViewModel.didLoad(tableView, viewController: self)
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        indexBlogViewModel.willAppear()
        navigationItem.rightBarButtonItem("New", target: self, action: #selector
            (IndexBlogViewController.modalNewBlog(_:)))
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK - TableView Delagate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 165
        } else {
            return 50
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let showBlogVC = UIStoryboard.viewControllerWith("Main", identifier: "ShowBlogViewController") as! ShowBlogViewController
            showBlogVC.blog = blogManager.blogAtPosition(indexPath.row)
            self.navigationController?.pushViewController(showBlogVC, animated: true)
        } else if indexPath.section == 1 {
            indexBlogViewModel.loadMoreItems()
        }
    }
    
    func modalNewBlog(sender: UIBarButtonItem) {
        performSegueWithIdentifier("ModalNewBlog", sender: nil)
    }
    
    func didTapProfileImageView(blog: Blog) {
        let showUserVC = UIStoryboard.viewControllerWith("Main", identifier: "ShowUserViewController") as! ShowUserViewController
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
