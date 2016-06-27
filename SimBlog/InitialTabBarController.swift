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

    var twoVCs: [UIViewController] = []
    var lastVC: UIViewController!
    
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
    
    
    func shouldTapItem(viewController: UIViewController) {
        self.lastVC = viewController.currentTopViewController
    }
    
    func didTappedItem(viewController: UIViewController) {
        let vc = viewController.childViewControllers.first!
        self.twoVCs.append(vc)
        if self.twoVCs.count == 3 { self.twoVCs.removeFirst() }
        if self.twoVCs.count < 2 { return }
        if self.twoVCs.first == self.twoVCs.last && self.twoVCs.last == self.lastVC {
            
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            
            if let followBVC = vc as? FollowingBlogViewController {
                if followBVC.currentUser.numberOfFollowingBlogs == 0 { return }
                followBVC.tableView.scrollToTopWithAnimate(indexPath)
            }
            
            if let indexBVC = vc as? IndexBlogViewController {
                indexBVC.collectionView.scrollToTopWithAnimate(indexPath)
            }
            
            if let noticeVC = vc as? NoticeViewController {
                if noticeVC.noticeViewModel.currentUser.numberOfNotices == 0 { return }
                noticeVC.tableView.scrollToTopWithAnimate(indexPath)
            }
            
            if let userVC = vc as? ShowUserViewController {
                userVC.tableView.scrollToTopWithAnimate(indexPath)
            }
            
        }
    }
}
