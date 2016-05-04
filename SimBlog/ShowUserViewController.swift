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
    var selectedBlog: Blog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MY PAGE"
        showUserViewModel.didLoad(tableView, user: currentUser)
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
        } else {
            return 165
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let showBlogVC = UIStoryboard.viewControllerWith("Main", identifier: "ShowBlogViewController") as! ShowBlogViewController
        showBlogVC.blog = currentUser.blogAtPosition(indexPath.row)
        self.navigationController?.pushViewController(showBlogVC, animated: true)
    }
}
