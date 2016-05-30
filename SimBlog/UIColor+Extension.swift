//
//  UIColor+Extension.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/30.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func mainColor() -> UIColor {
        return UIColor(red: 233/255, green: 75/255, blue: 53/233, alpha: 1.0)
    }
    
    class func white() -> UIColor {
        return UIColor.whiteColor()
    }
    
    class func maingGray() -> UIColor {
        return UIColor.darkGrayColor()
    }
}