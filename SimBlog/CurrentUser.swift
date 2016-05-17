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
    var notices: [Notice] = []
    var numberOfNotices: Int {
        return notices.count
    }
    
    func getCurrentUserInLocal() {
        let defaults = NSUserDefaults.standardUserDefaults()
        self.name = defaults.objectForKey("user_name") as! String
        self.email = defaults.objectForKey("user_email") as? String
        self.imageURL = defaults.objectForKey("user_image_url") as! String
        self.facebook_id = defaults.objectForKey("facebook_id") as! String
        self.id = defaults.objectForKey("id") as! Int
        self.token = defaults.objectForKey("user_token") as! String
    }
    
    func getFollowingBlogsInBackground(page: Int, callback: () -> Void) {
        SVProgressHUD.show()
        let params = [
            "id": self.id,
            "page": page
        ]
        Alamofire.request(.GET, String.rootPath() + "/api/blogs/following", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                let json = JSON(object)
                SVProgressHUD.dismiss()
                for object in json["blogs"].array! {
                    let blog = Blog(apiAttributes: object["blog"])
                    blog.user = User(apiAttributes: object["user"])
                    self.followingBlogs.insert(blog, atIndex: self.numberOfFollowingBlogs)
                    callback()
                }
        }
    }
}
