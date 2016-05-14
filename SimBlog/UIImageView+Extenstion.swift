//
//  UIImageView+Extenstion.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/14.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func aspectFill() {
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.layer.masksToBounds = true
    }
}