//
//  UIApplication+Extension.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/29.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

extension UIApplication {
    
    class func redirectToInitialViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewControllerWithIdentifier("InitialTabBarController")
        UIApplication.sharedApplication().keyWindow?.rootViewController = initialViewController
    }
    
    class func redirectToLoginViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
    }
}