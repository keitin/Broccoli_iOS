//
//  InitialTabBarController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class InitialTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let followingBlogNC = UIStoryboard.viewControllerWith("Blog", identifier: "FollowingBlogNavigationController")
        let blogNC = UIStoryboard.viewControllerWith("Blog", identifier: "BlogNavigationController")
        let userNC = UIStoryboard.viewControllerWith("User", identifier: "UserNavigationController")
        
        setViewControllers([followingBlogNC, blogNC, userNC], animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
