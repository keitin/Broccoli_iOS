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
    
    class func broccoli() -> UIColor {
        return UIColor(red: 123/255, green: 201/255, blue: 195/255, alpha: 1.0)
    }
    
    class func disableGray() -> UIColor {
        return UIColor(red: 189/255, green: 193/255, blue: 201/255, alpha: 1.0)
    }
}