//
//  Notice.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/14.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SwiftyJSON

class Notice: NSObject {
    var blog: Blog!
    var user: User!
    var text: String {
        return "\(user.name)さんがあなたの投稿にイイネをしました"
    }
    
    init(blog: Blog, user: User) {
        self.blog = blog
        self.user = user
    }
}
