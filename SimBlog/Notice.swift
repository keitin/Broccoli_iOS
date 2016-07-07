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


class Notice: NSObject {
    var blog: Blog?
    var user: User!
    var fromUser: User
    var category: NoticeCategory
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
    
    init(blog: Blog?, user: User, fromUser :User, category: NoticeCategory) {
        self.blog = blog
        self.user = user
        self.fromUser = fromUser
        self.category = category
    }
}
