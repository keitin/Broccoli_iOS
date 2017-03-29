//
//  Notice.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/14.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SwiftyJSON

enum NoticeCategory: Int {
    case Like = 0
    case Followed = 1
    case Comment = 2
    
    static func createCategory(category: String) -> NoticeCategory {
        switch category {
        case "like":
            return .Like
        case "followed":
            return .Followed
        case "comment":
            return .Comment
        default:
            return .Like
        }
    }
}

enum NoticeStatus: Int {
    case UnRead = 0
    case Read = 1
    
    static func createNoticeStatus(status: String) -> NoticeStatus {
        switch status {
        case "unread":
            return .UnRead
        case "read":
            return .Read
        default:
            return .UnRead
        }
    }
}


class Notice: NSObject {
    var id: Int!
    var blog: Blog?
    var user: User!
    var fromUser: User
    var category: NoticeCategory
    var status: NoticeStatus
    var text: String {
        switch self.category {
        case .Like:
            return "\(fromUser.name)さんがあなたの投稿にイイネをしました。"
        case .Followed:
            return "\(fromUser.name)さんがあなたをフォローしました。"
        case .Comment:
            return "\(fromUser.name)さんがあなたの投稿にコメントしました。"
        }
    }
    var isUnRead: Bool {
        if self.status == .UnRead {
            return true
        } else {
            return false
        }
    }
    
    init(blog: Blog?, notice: JSON) {
        self.blog = blog
        self.user = User(apiAttributes: notice["user"])
        self.fromUser = User(apiAttributes: notice["from_user"])
        self.category = NoticeCategory.createCategory(notice["notice"]["category"].string!)
        self.status = NoticeStatus.createNoticeStatus(notice["notice"]["status"].string!)
        self.id = notice["notice"]["id"].int!
    }
}
