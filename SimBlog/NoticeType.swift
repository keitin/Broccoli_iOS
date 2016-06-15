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
                currentUser.notices = []
                let json = JSON(object)
                for notice in json["notices"].array! {
                    let blog = Blog(apiAttributes: notice["blog"])
                    let user = User(apiAttributes: notice["user"])
                    let blogUser = User(apiAttributes: notice["blog_user"])
                    blog.user = blogUser
                    let notice = Notice(blog: blog, user: user)
                    currentUser.notices.insert(notice, atIndex: currentUser.numberOfNotices)
                    callback()
                }
        }
    }
}
