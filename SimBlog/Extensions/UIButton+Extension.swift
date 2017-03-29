//
//  UIButton+Extension.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/29.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func animateWithLove() {
        let buruburuAnim = CAKeyframeAnimation(keyPath: "transform.rotation")
        buruburuAnim.duration = 0.25
        buruburuAnim.repeatCount = 3.0
        buruburuAnim.values = [0.0, -M_PI_4/4, 0.0, M_PI_4/4 , 0.0]
        buruburuAnim.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        self.layer.addAnimation(buruburuAnim, forKey: "size")
    }
}