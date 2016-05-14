//
//  NoticeViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/14.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController, UITableViewDelegate, NoticeCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    let noticeViewModel = NoticeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeViewModel.didLoad(tableView, viewController: self)
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        noticeViewModel.willLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    //MARK: Notice Cell Delegate
    func didTapBlogImageView(blog: Blog) {
        let showBlogVC = UIStoryboard.viewControllerWith("Blog", identifier: "ShowBlogViewController") as! ShowBlogViewController
        showBlogVC.blog = blog
        self.navigationController?.pushViewController(showBlogVC, animated: true)
    }
    
    func didTapUserImageView(user: User) {
        let showUserVC = UIStoryboard.viewControllerWith("User", identifier: "ShowUserViewController") as! ShowUserViewController
        showUserVC.selectedUser = user
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
