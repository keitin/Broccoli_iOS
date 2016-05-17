//
//  InitialTabBarController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import ReachabilitySwift
import JDStatusBarNotification

class InitialTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let followingBlogNC = UIStoryboard.viewControllerWith("Blog", identifier: "FollowingBlogNavigationController")
        let blogNC = UIStoryboard.viewControllerWith("Blog", identifier: "BlogNavigationController")
        let userNC = UIStoryboard.viewControllerWith("User", identifier: "UserNavigationController")
        let noticeNC = UIStoryboard.viewControllerWith("Notice", identifier: "NoticeNavigationController")
        blogNC.title = "Search"
        userNC.title = "My Page"
        noticeNC.title = "Notice"
        
        setViewControllers([followingBlogNC, blogNC, noticeNC, userNC], animated: true)
        
        
        var reachability: Reachability?
        
        //declare this inside of viewWillAppear
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InitialTabBarController.reachabilityChanged(_:)) ,name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() {
            JDStatusBarNotification.dismiss()
            if reachability.isReachableViaWiFi() {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        } else {
            JDStatusBarNotification.showWithStatus("Error", styleName: JDStatusBarStyleError)
            print("Network not reachable")
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
