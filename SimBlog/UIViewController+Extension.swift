//
//  UIViewController+Extension.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/15.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var currentTopViewController: UIViewController? {
        if let viewController = self as? UINavigationController {
            return viewController.topViewController?.currentTopViewController
        }
        if let viewController = self as? UITabBarController {
            return viewController.selectedViewController?.currentTopViewController
        }
        if let viewController = self.presentedViewController {
            return viewController.currentTopViewController
        }
        return self
    }
    
}