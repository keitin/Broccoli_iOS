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
    
    func leftImageButtonItem(image: String, target: AnyObject, action: Selector) {
        self.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: image), style: .Plain, target: target, action: action)
    }
    
    func rightImageButtonItem(image: String, target: AnyObject, action: Selector) {
        self.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: image), style: .Plain, target: target, action: action)
    }
    
    func loveButtonItem(target: AnyObject, action: Selector, selected: Bool) -> UIBarButtonItem {
        let loveButton = UIButton()
        loveButton.selected = selected
        loveButton.frame.size = CGSize(width: 25, height: 25)
        loveButton.setImage(UIImage(named: "Love-50"), forState: .Normal)
        loveButton.setImage(UIImage(named: "Love-Filled-50"), forState: .Selected)
        loveButton.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return UIBarButtonItem(customView: loveButton)
    }
}

