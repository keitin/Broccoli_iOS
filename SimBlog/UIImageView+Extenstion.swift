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
    
    func makeCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
    
    func lineBorderWhite() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func animateWith(duration: NSTimeInterval, fromAlpha: CGFloat) {
        self.alpha = fromAlpha
        UIView.animateWithDuration(duration) { 
            self.alpha = 1.0
        }
    }
}