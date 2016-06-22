//
//  Block.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/22.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD


protocol Block {
    func block(fromUser: User, toUser: User, callback: () -> Void)
    func removeBlock(fromUser: User, toUser: User, callback: () -> Void)
    func isBlock(fromUser: User, toUser: User, callback: (isBlocked: Bool, isBlocking: Bool) -> Void)
}

extension Block {
    func block(fromUser: User, toUser: User, callback: () -> Void) {
        SVProgressHUD.show()
        let params = [
            "target_user_id": toUser.id
        ]
        Alamofire.request(.POST, String.rootPath() + "/api/users/\(fromUser.id)/blocks", parameters: params)
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
    
    func removeBlock(fromUser: User, toUser: User, callback: () -> Void) {
        SVProgressHUD.show()
        let params = [
            "target_user_id": toUser.id,
            "user_id": fromUser.id
        ]
        Alamofire.request(.DELETE, String.rootPath() + "/api/users/\(fromUser.id)/blocks/hoge", parameters: params)
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
    
    func isBlock(fromUser: User, toUser: User, callback: (isBlocked: Bool, isBlocking: Bool) -> Void) {
        SVProgressHUD.show()
        let params = [
            "target_user_id": toUser.id
        ]
        Alamofire.request(.GET, String.rootPath() + "/api/users/\(fromUser.id)/blocks/is_blocked", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                SVProgressHUD.dismiss()
                let json = JSON(object)
                callback(isBlocked: json["is_blocked"].bool!, isBlocking: json["is_blocking"].bool!)
        }
    }
}