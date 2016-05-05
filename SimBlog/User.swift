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

class User: NSObject {
    var name: String!
    var imageURL: String!
    var id: Int!
    var facebook_id: String!
    var email: String?
    var token: String!
    var blogs: [Blog] = []
    var numberOfBlogs: Int {
        return blogs.count
    }
    
    override init() {
        super.init()
    }
    
    init(facebookAttributes: JSON) {
        self.name = facebookAttributes["name"].string!
        self.imageURL = facebookAttributes["picture"]["data"]["url"].string!
        self.facebook_id = facebookAttributes["id"].string!
        self.email = facebookAttributes["email"].string
    }
    
    init(apiAttributes: JSON) {
        self.name = apiAttributes["name"].string
        self.imageURL = apiAttributes["image_url"].string
        self.email = apiAttributes["email"].string
        self.facebook_id = apiAttributes["facebook_id"].string
        self.id = apiAttributes["id"].int
    }
    
    func blogAtPosition(index: Int) -> Blog {
        return blogs[index]
    }
    
    func addBlogAtPosition(blog: Blog, index: Int) {
        blogs.insert(blog, atIndex: index)
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
                    return
                }
                let json = JSON(object)
                self.id = json["user"]["id"].int
                callback()
        }
    }
    
    func getBlogsInBackground(callback: () -> Void) {
        Alamofire.request(.GET, String.rootPath() + "/api/blogs/?user_id=\(self.id)", parameters: nil)
            .responseJSON { response in
                guard let object = response.result.value else {
                    print("えらー")
                    print(response)
                    return
                }
                let json = JSON(object)
                for object in json["blogs"].array! {
                    let blog = Blog()
                    blog.title = object["blog"]["title"].string
                    blog.sentence = object["blog"]["sentence"].string
                    blog.topImageURL = object["blog"]["image"]["url"].string
                    blog.id = object["blog"]["id"].int
                    blog.user = User(apiAttributes: object["user"])
                    self.blogs.insert(blog, atIndex: 0)
                    callback()
                }
        }
    }
    
    
    //MAEK - User Defaults
    func saveCurrentUserInLocal() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.name, forKey: "user_name")
        defaults.setObject(self.email, forKey: "user_email")
        defaults.setObject(self.imageURL, forKey: "user_image_url")
        defaults.setObject(self.id, forKey: "id")
        defaults.setObject(self.facebook_id, forKey: "facebook_id")
        defaults.setObject(self.token, forKey: "user_token")
        defaults.synchronize()
    }
    
}
