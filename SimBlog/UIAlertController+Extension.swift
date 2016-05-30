//
//  UIAlertController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/30.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func okAlert(text: String) -> UIAlertController {
        let alert = UIAlertController(title: "エラー", message: text, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(OKAction)
        return alert
    }
}