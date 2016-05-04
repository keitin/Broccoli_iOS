//
//  CurrentUser.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/29.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

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

}
