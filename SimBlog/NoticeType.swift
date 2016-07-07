//
//  NoticeType.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/14.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

protocol NoticeType {
    func getNoticesInBackground(currentUser: CurrentUser, page: Int, callback: () -> Void)
}

extension NoticeType {
    func getNoticesInBackground(currentUser: CurrentUser, page: Int, callback: () -> Void) {
        SVProgressHUD.show()
        let params = [
            "page": page
        ]
        Alamofire.request(.GET, String.rootPath() + "/api/users/\(currentUser.id)/notices", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                SVProgressHUD.dismiss()
                if page == 1 { currentUser.notices = [] }
                let json = JSON(object)
                for notice in json["notices"].array! {
                    let user = User(apiAttributes: notice["user"])
                    let fromUser = User(apiAttributes: notice["from_user"])
                    let category = NoticeCategory.createCategory(notice["notice"]["category"].string!)
                    var blog: Blog? = nil
                    let blogUser: User?
                    if let _ = notice["blog"].dictionary {
                        blog = Blog(apiAttributes: notice["blog"])
                        blogUser = User(apiAttributes: notice["blog_user"])
                        blog!.user = blogUser
                    }
                    let notice = Notice(blog: blog, user: user, fromUser: fromUser, category: category)
                    currentUser.notices.insert(notice, atIndex: currentUser.numberOfNotices)
                    callback()
                }
        }
    }
}
