//
//  Follow.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/13.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

protocol Follow {
    func follow(fromUser: User, toUser: User, callback: () -> Void)
    func unfollow(fromUser: User, toUser: User, callback: () -> Void)
    func isFollow(fromUser: User, toUser: User, callback: (isFollow: Bool) -> Void)
}

extension Follow {

    func follow(fromUser: User, toUser: User, callback: () -> Void) {
        SVProgressHUD.show()
        let params = [
            "target_user_id": toUser.id
        ]
        Alamofire.request(.POST, String.rootPath() + "/api/users/\(fromUser.id)/follow", parameters: params)
            .responseJSON { response in
                guard let _ = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                SVProgressHUD.dismiss()
                callback()
        }
    }
    
    func unfollow(fromUser: User, toUser: User, callback: () -> Void) {
        SVProgressHUD.show()
        let params = [
            "target_user_id": toUser.id
        ]
        Alamofire.request(.DELETE, String.rootPath() + "/api/users/\(fromUser.id)/unfollow", parameters: params)
            .responseJSON { response in
                guard let _ = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                SVProgressHUD.dismiss()
                callback()
        }
    }
    
    func isFollow(fromUser: User, toUser: User, callback: (isFollow: Bool) -> Void) {
        SVProgressHUD.show()
        let params = [
            "target_user_id": toUser.id
        ]
        Alamofire.request(.GET, String.rootPath() + "/api/users/\(fromUser.id)/is_follow", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                SVProgressHUD.dismiss()
                let json = JSON(object)
                callback(isFollow: json["is_follow"].bool!)
        }
    }
}

