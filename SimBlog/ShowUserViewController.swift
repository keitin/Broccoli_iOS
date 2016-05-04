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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MY PAGE"
        showUserViewModel.didLoad(tableView, user: currentUser)
        tableView.delegate = self
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
}
