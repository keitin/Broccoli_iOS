//
//  User.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/28.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Bond
import SVProgressHUD

class User: NSObject {
    var name: String!
    var imageURL: String!
    var id: Int!
    var facebook_id: String!
    var token: String!
    var blogs: [Blog] = []
    var followingBlogs: [Blog] = []
    var follows: [User] = []
    var followers: [User] = []
    var numberOfBlogs: Int { return blogs.count }
    var numberOfFollows: Int { return follows.count }
    var numberOfFollowers: Int { return followers.count }
    var numberOfFollowingBlogs: Int { return followingBlogs.count }
    var blocked = false
    var blocking = Observable<Bool>(false)
    
    //Own Login Attributes
    var iconImage: UIImage?
    var email: String? = ""
    var password: String? = ""
    
    override init() {
        super.init()
    }
    
    init(facebookAttributes: JSON) {
        self.name = facebookAttributes["name"].string!
        self.imageURL = facebookAttributes["picture"]["data"]["url"].string!
        self.facebook_id = facebookAttributes["id"].string!
        
        if let email = facebookAttributes["email"].string {
            self.email = email
        } else {
            self.email = ""
        }
        
    }
    
    init(apiAttributes: JSON) {
        self.name = apiAttributes["name"].string
        if let image =  apiAttributes["image_url"].string {
            self.imageURL = image
        } else {
            self.imageURL = apiAttributes["avatar"]["url"].string!
        }
        self.token = apiAttributes["token"].string
        self.email = apiAttributes["email"].string
        self.facebook_id = apiAttributes["facebook_id"].string
        self.id = apiAttributes["id"].int
    }
    
    init(ownLoginAttributes: [String: AnyObject]) {
        self.name = ownLoginAttributes["name"] as! String
        self.email = ownLoginAttributes["email"] as? String
        self.password = ownLoginAttributes["password"] as? String
        self.iconImage = ownLoginAttributes["image"] as? UIImage
    }
    
    init(ownSessionAttributes: JSON) {
        self.email = ownSessionAttributes["email"].string!
        self.password = ownSessionAttributes["password"].string!
    }
    
    func followingBlogAtPosition(index: Int) -> Blog {
        return followingBlogs[index]
    }
    
    func blogAtPosition(index: Int) -> Blog {
        return blogs[index]
    }
    
    func addBlogAtPosition(blog: Blog, index: Int) {
        blogs.insert(blog, atIndex: index)
    }
    
    func addFollowingBlogAtPostion(blog: Blog, index: Int) {
        for followBlog in followingBlogs {
            if followBlog.id == blog.id { return }
        }
        followingBlogs.insert(blog, atIndex: index)
    }
    
    func issueToken() {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateString = dateFormatter.stringFromDate(now)
        let randomValue = arc4random() % 100000
        let token = dateString + String(randomValue)
        self.token = token
    }
    
    class func userSignedIn() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let _ = defaults.objectForKey("user_token") {
            return true
        } else {
            return false
        }
    }
    
    //API
    func saveInbackground(callback: () -> Void) {
        let params = [
            "name": self.name,
            "image_url": self.imageURL,
            "facebook_id": self.facebook_id,
            "email": self.email,
            "token": self.token
        ]
        
        Alamofire.request(.POST, String.rootPath() + "/api/users/", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                let json = JSON(object)
                self.id = json["user"]["id"].int
                callback()
        }
    }
    
    func saveAsOwnLogin(callback: (message: String?) -> Void) {
        SVProgressHUD.show()
        let params = [
            "name": self.name,
            "password": self.password,
            "password_confirmation": self.password,
            "token": self.token,
            "email": self.email
        ]
        
        let pass = String.rootPath() + "/api/users/"
        let httpMethod = Alamofire.Method.POST.rawValue
        
        let urlRequest = NSData.urlRequestWithComponents(httpMethod, urlString: pass, parameters: params, image: self.iconImage!)
        Alamofire.upload(urlRequest.0, data: urlRequest.1)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    SVProgressHUD.dismiss()
                    callback(message: ErrorMessage.noNetWork)
                    return
                }
                
                SVProgressHUD.dismiss()
                StatusBarNotification.hideMessage()
                
                let json = JSON(object)
                
                if let message = json["error_message"].array {
                    callback(message: message.first?.string)
                    return
                }
                
                self.imageURL = json["user"]["avatar"]["url"].string!
                self.id = json["user"]["id"].int!
                self.facebook_id = ""
                callback(message: nil)
        }
    }
    
    func saveAsSession(completion: (user: User?, message: String?) -> Void) {
        SVProgressHUD.show()
        let params = [
            "email": self.email!,
            "password": self.password!
        ]
        Alamofire.request(.POST, String.rootPath() + "/api/sessions", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    completion(user: nil, message: ErrorMessage.noNetWork)
                    return
                }
                SVProgressHUD.dismiss()
                StatusBarNotification.hideMessage()
                let json = JSON(object)
                
                if let message = json["error_message"].string {
                    completion(user: nil, message: message)
                    return
                }
                
                let user = User(apiAttributes: json["user"])
                user.facebook_id = ""
                completion(user: user, message: nil)
        }
    }
    
    func getBlogsInBackground(page: Int, callback: () -> Void) {
        let params = [
            "page": page
        ]
        Alamofire.request(.GET, String.rootPath() + "/api/blogs/?user_id=\(self.id)", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                if page == 1 { self.blogs = [] }
                StatusBarNotification.hideMessage()
                let json = JSON(object)
                for object in json["blogs"].array! {
                    let blog = Blog(apiAttributes: object["blog"])
                    blog.user = User(apiAttributes: object["user"])
                    self.blogs.insert(blog, atIndex: self.numberOfBlogs)
                    callback()
                }
        }
    }
    
    //MARK User Follow etc
    func getFollowsInBackground(callback: () -> Void) {
        self.follows = []
        Alamofire.request(.GET, String.rootPath() + "/api/users/\(self.id)/following", parameters: nil)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                let json = JSON(object)
                for followUser in json["follows"].array! {
                    let user = User(apiAttributes: followUser["follow_user"])
                    self.follows.insert(user, atIndex: 0)
                    callback()
                }
        }
    }
    
    func getFollowersInBackground(callback: () -> Void) {
        self.followers = []
        Alamofire.request(.GET, String.rootPath() + "/api/users/\(self.id)/followers", parameters: nil)
            .responseJSON { response in
                guard let object = response.result.value else {
                    StatusBarNotification.showErrorMessage()
                    return
                }
                StatusBarNotification.hideMessage()
                let json = JSON(object)
                for followerUser in json["followers"].array! {
                    let user = User(apiAttributes: followerUser["follower_user"])
                    self.followers.insert(user, atIndex: 0)
                    callback()
                }
        }
    }

    //MAEK - User Defaults
    func saveCurrentUserInLocal() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.name, forKey: "user_name")
        defaults.setObject(self.email!, forKey: "user_email")
        defaults.setObject(self.imageURL, forKey: "user_image_url")
        defaults.setObject(self.id, forKey: "id")
        defaults.setObject(self.facebook_id, forKey: "facebook_id")
        defaults.setObject(self.token, forKey: "user_token")
        defaults.synchronize()
    }
    
}
