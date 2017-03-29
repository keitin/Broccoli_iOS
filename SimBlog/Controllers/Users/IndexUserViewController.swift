//
//  FollowViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/07.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

enum DisplayType {
    case Follows, Followers
}

class IndexUserViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let indexUserViewModel = IndexUserViewModel()
    var displayType: DisplayType!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if displayType == DisplayType.Follows {
            title = "Follows"
        } else {
            title = "Followers"
        }
        
        tableView.delegate = self
        indexUserViewModel.didLoad(tableView, user: user, displayType: displayType)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - TableView Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let showUserVC = UIStoryboard.viewControllerWith("User", identifier: "ShowUserViewController") as! ShowUserViewController
        if displayType == DisplayType.Follows {
            showUserVC.selectedUser = user.follows[indexPath.row]
        } else {
            showUserVC.selectedUser = user.followers[indexPath.row]
        }
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
