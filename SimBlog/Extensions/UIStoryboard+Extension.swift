//
//  UIStoryboard+Extension.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/04.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    class func viewControllerWith(boardName: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: boardName, bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(identifier)
    }
}

