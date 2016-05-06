//
//  CurrentUser.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/29.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class CurrentUser: User {
    static let sharedInstance = CurrentUser()
    
    func getCurrentUserInLocal() {
        let defaults = NSUserDefaults.standardUserDefaults()
        self.name = defaults.objectForKey("user_name") as! String
        self.email = defaults.objectForKey("user_email") as? String
        self.imageURL = defaults.objectForKey("user_image_url") as! String
        self.facebook_id = defaults.objectForKey("facebook_id") as! String
        self.id = defaults.objectForKey("id") as! Int
        self.token = defaults.objectForKey("user_token") as! String
    }
    
    //MARK - Follow etc
    func follow(user: User, callback: () -> Void) {
        SVProgressHUD.show()
        let params = [
            "target_user_id": user.id
        ]
        Alamofire.request(.POST, String.rootPath() + "/api/users/\(self.id)/follow", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                SVProgressHUD.dismiss()
                let json = JSON(object)
                print(json)
                callback()
        }
    }
    
    func unfollow(user: User, callback: () -> Void) {
        SVProgressHUD.show()
        let params = [
            "target_user_id": user.id
        ]
        Alamofire.request(.DELETE, String.rootPath() + "/api/users/\(self.id)/unfollow", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                SVProgressHUD.dismiss()
                let json = JSON(object)
                print(json)
                callback()
        }
    }
    
    func isFollow(user: User, callback: (isFollow: Bool) -> Void) {
        SVProgressHUD.show()
        let params = [
            "target_user_id": user.id
        ]
        Alamofire.request(.GET, String.rootPath() + "/api/users/\(self.id)/is_follow", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                SVProgressHUD.dismiss()
                let json = JSON(object)
                callback(isFollow: json["is_follow"].bool!)
        }
    }
    
    func getFollowsInBackground(callback: () -> Void) {
        Alamofire.request(.GET, String.rootPath() + "/api/users/\(self.id)/following", parameters: nil)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print(json)
                callback()
        }
    }

}
