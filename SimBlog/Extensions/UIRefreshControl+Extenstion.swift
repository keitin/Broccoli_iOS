//
//  UIRefreshControl+Extenstion.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/15.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIRefreshControl {
    
    class func loadingItems(target: AnyObject, selector: Selector) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: Message.loading)
        refreshControl.addTarget(target, action: selector, forControlEvents: .ValueChanged)
        return refreshControl
    }
    
}