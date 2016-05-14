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
    func getNoticesInBackground(currentUser: CurrentUser, callback: () -> Void)
}

extension NoticeType {
    func getNoticesInBackground(currentUser: CurrentUser, callback: () -> Void) {
        SVProgressHUD.show()
        Alamofire.request(.GET, String.rootPath() + "/api/users/\(currentUser.id)/notices", parameters: nil)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                SVProgressHUD.dismiss()
                let json = JSON(object)
                currentUser.notices = []
                for notice in json["notices"].array! {
                    print(notice)
                    let blog = Blog(apiAttributes: notice["blog"])
                    let user = User(apiAttributes: notice["user"])
                    let blogUser = User(apiAttributes: notice["blog_user"])
                    blog.user = blogUser
                    let notice = Notice(blog: blog, user: user)
                    currentUser.notices.insert(notice, atIndex: 0)
                    callback()
                }
        }
    }
}
