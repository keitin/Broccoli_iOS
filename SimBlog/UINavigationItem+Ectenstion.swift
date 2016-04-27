//
//  UINavigationItem+Ectenstion.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    func leftBarButtonItem(title: String, target: AnyObject, action: Selector) {
        self.leftBarButtonItem = UIBarButtonItem(title: title, style: .Done, target: target, action: action)
    }
    
    func rightBarButtonItem(title: String, target: AnyObject, action: Selector) {
        self.rightBarButtonItem = UIBarButtonItem(title: title, style: .Done, target: target, action: action)
    }
}

