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
        let blogNC          = UIStoryboard.viewControllerWith("Blog", identifier: "BlogNavigationController")
        let noticeNC        = UIStoryboard.viewControllerWith("Notice", identifier: "NoticeNavigationController")
        let userNC          = UIStoryboard.viewControllerWith("User", identifier: "UserNavigationController")
        setViewControllers([followingBlogNC, blogNC, noticeNC, userNC], animated: true)
        var reachability: Reachability?
        
        followingBlogNC.childViewControllers.first!.title = "Home"
        blogNC.childViewControllers.first!.title          = "Search"
        noticeNC.childViewControllers.first!.title        = "Love"
        userNC.childViewControllers.first!.title          = "Profile"
        
        
        
        //tab bar icons
        let mainColor = UIColor.mainColor()
        
        let homeImage          = makeOriginalImage("Home-50")
        let hommeSelectedImage = makeOriginalImage("Home-selected-50")
        let search             = makeOriginalImage("Search-50")
        let selecterSearch     = makeOriginalImage("Search-selected-50")
        let heart              = makeOriginalImage("Hearts-50")
        let selectedHeart      = makeOriginalImage("Hearts-selected-50")
        let profile      = makeOriginalImage("Contacts-50@2x")
        let selectedProfile      = makeOriginalImage("Contacts-selected-50@2x")
        
        let followingController = self.viewControllers![0]
        let seachController     = self.viewControllers![1]
        let loveController      = self.viewControllers![2]
        let profileController      = self.viewControllers![3]
        
        let selectedAttributes = [NSForegroundColorAttributeName: mainColor]
         UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, forState: UIControlState.Selected)
        
        followingController.tabBarItem  = UITabBarItem(title: "home", image: homeImage, selectedImage: hommeSelectedImage)
        seachController.tabBarItem  = UITabBarItem(title: "seach", image: search, selectedImage: selecterSearch)
        loveController.tabBarItem  = UITabBarItem(title: "love", image: heart, selectedImage: selectedHeart)
        profileController.tabBarItem  = UITabBarItem(title: "profile", image: profile, selectedImage: selectedProfile)
        
        
        // MARK: Navigation Bar Layout
        UINavigationBar.appearance().barTintColor = UIColor.white()
        UINavigationBar.appearance().tintColor = UIColor.mainColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.mainColor(), NSFontAttributeName: UIFont(name: "Helvetica", size: 20)!]
        
        
        
        
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
    
    //オリジナル画像を生成
    func makeOriginalImage(name: String) -> UIImage {
        let image = UIImage(named: name)!
        let originalImage = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        return originalImage
    }

}
