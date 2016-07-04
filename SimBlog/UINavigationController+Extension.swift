//
//  UINavigationController+Extension.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/07/04.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func previousViewController() -> UIViewController {
        return self.viewControllers[self.viewControllers.count - 2]
    }
    
}