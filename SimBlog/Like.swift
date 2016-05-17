//
//  Like.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/12.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol Like {
    func likeInBackground(blog: Blog, callback: () -> Void)
    func deleteLikeInBackground(blog: Blog, callback: () -> Void)
    func isLike(blog: Blog, callback: (isLike: Bool) -> Void)
}

extension Like {
    
    func likeInBackground(blog: Blog, callback: () -> Void) {
        let params = ["user_id": CurrentUser.sharedInstance.id]
        Alamofire.request(.POST, String.rootPath() + "/api/blogs/\(blog.id)/likes", parameters: params)
            .responseJSON { response in
                guard let _ = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                callback()
        }
    }
    
    func deleteLikeInBackground(blog: Blog, callback: () -> Void) {
        let params = ["user_id": CurrentUser.sharedInstance.id]
        Alamofire.request(.DELETE, String.rootPath() + "/api/blogs/\(blog.id)/likes/0", parameters: params)
            .responseJSON { response in
                guard let _ = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                callback()
        }
    }
    
    func isLike(blog: Blog, callback: (isLike: Bool) -> Void) {
        let params = ["user_id": CurrentUser.sharedInstance.id]
        Alamofire.request(.GET, String.rootPath() + "/api/blogs/\(blog.id)/likes/is_like", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                let json = JSON(object)
                callback(isLike: json["is_like"].bool!)
        }
    }
}