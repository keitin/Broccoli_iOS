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
    class func okAlert(text: String?) -> UIAlertController {
        let alert = UIAlertController(title: "エラー", message: text, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(OKAction)
        return alert
    }
    
    class func okAlertWithMessage(message: String?) -> UIAlertController {
        var alert = UIAlertController(title: "完了しました", message: nil, preferredStyle: .Alert)
        if let msg = message {
            alert = UIAlertController(title: msg, message: nil, preferredStyle: .Alert)
        }
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(OKAction)
        return alert
    }
    
    class func actionSheet(title: String, message: String) -> UIAlertController {
        let sheet = UIAlertController(title: .None, message: .None, preferredStyle: .ActionSheet)
        let cancel = UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil)
        sheet.addAction(cancel)
        return sheet
    }
    
    class func reportSelectAction(callback: (reportType: ReportType) -> Void) -> UIAlertController {
        let sheet = UIAlertController(title: .None, message: .None, preferredStyle: .ActionSheet)
        let spam = UIAlertAction(title: "スパムである", style: .Default) { (action) in
            callback(reportType: ReportType.Spam)
        }
        sheet.addAction(spam)
        let objectionable = UIAlertAction(title: "不適切である", style: .Default) { (action) in
            callback(reportType: ReportType.Objectionable)
        }
        sheet.addAction(objectionable)
        let cancel = UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil)
        sheet.addAction(cancel)
        return sheet
    }
}