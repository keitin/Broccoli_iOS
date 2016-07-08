//
//  UIView+Extenstion.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    func lineBorderBottom(borderWidth borderWidth: CGFloat, color: UIColor) {
        let border = CALayer()
        border.borderColor = color.CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.addSublayer(border)
        self.masksToBounds = true
    }
    
    func lineBorderTop(borderWidth borderWidth: CGFloat, color: UIColor) {
        let border = CALayer()
        border.borderColor = color.CGColor
        border.frame = CGRect(x: 0, y: 0, width:  self.frame.size.width, height: borderWidth)
        border.borderWidth = borderWidth
        self.addSublayer(border)
        self.masksToBounds = true
    }
}
