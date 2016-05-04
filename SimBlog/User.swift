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
    
    override init() {
        super.init()
    }
    
    init(attributes: JSON) {
        self.name = attributes["name"].string!
        self.imageURL = attributes["picture"]["data"]["url"].string!
        self.facebook_id = attributes["id"].string!
        self.email = attributes["email"].string
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
