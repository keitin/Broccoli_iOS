//
//  ShowBlogViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class ShowBlogViewController: UIViewController, DisplayTitleCellDelegate {
    

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
