//
//  StatusBarNotification.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/17.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import JDStatusBarNotification

class StatusBarNotification: NSObject {
    
    class func showErrorMessage() {
        JDStatusBarNotification.addStyleNamed("ConnectError") { (style) -> JDStatusBarStyle! in
            style.textColor = UIColor.whiteColor()
            style.barColor = UIColor.redColor()
            return style
        }
        JDStatusBarNotification.showWithStatus("Error", styleName: "ConnectError")
    }
    
    class func hideMessage() {
        JDStatusBarNotification.dismiss()
    }
    
}
