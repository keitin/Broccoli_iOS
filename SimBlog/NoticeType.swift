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
    func getUnReadNoitceCount(currentUser: CurrentUser, completion: (count: Int) -> Void)
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
                    var blog: Blog? = nil
                    let blogUser: User?
                    if let _ = notice["blog"].dictionary {
                        blog = Blog(apiAttributes: notice["blog"])
                        blogUser = User(apiAttributes: notice["blog_user"])
                        blog!.user = blogUser
                    }
                    let notice = Notice(blog: blog, notice: notice)
                    currentUser.notices.insert(notice, atIndex: currentUser.numberOfNotices)
                    callback()
                }
                callback()
        }
    }
    
    func getUnReadNoitceCount(currentUser: CurrentUser, completion: (count: Int) -> Void) {
        Alamofire.request(.GET, String.rootPath() + "/api/users/\(currentUser.id)/notices/count", parameters: nil)
            .responseJSON { response in
                guard let object = response.result.value else {   
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                let json = JSON(object)
                let count = json["count"].int!
                completion(count: count)
        }
    }
    
    func makeNoticeRead(user: User, notice: Notice) {
        Alamofire.request(.PATCH, String.rootPath() + "/api/users/\(user.id)/notices/\(notice.id)", parameters: nil)
            .responseJSON { response in
                guard let _ = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
        }
    }
}
