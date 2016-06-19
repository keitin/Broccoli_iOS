//
//  UserReport.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/19.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

enum ReportType: Int {
    case Spam = 0
    case Objectionable = 1
}

protocol Report {
    func reportUser(user: User, blog: Blog?, reportType: ReportType, callback: (message: String?) -> Void)
}

extension Report {
    func reportUser(user: User, blog: Blog?, reportType: ReportType, callback: (message: String?) -> Void) {
        var params: [String: AnyObject] = [
            "user_id": user.id,
            "report_type": reportType.rawValue
        ]
        if let blog = blog {
            params["blog_id"] = blog.id
        }
        
        SVProgressHUD.show()
        Alamofire.request(.POST, String.rootPath() + "/api/reports", parameters: params)
            .responseJSON { response in
                guard let _ = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    callback(message: ErrorMessage.failToReport)
                    return
                }
                StatusBarNotification.hideMessage()
                SVProgressHUD.dismiss()
                callback(message: nil)
        }
        
    }
}