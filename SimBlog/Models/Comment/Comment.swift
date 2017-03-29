//
//  Comment.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/07/06.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Comment: NSObject {
    var text: String
    var user: User
    
    init(text: String, user: User) {
        self.text = text
        self.user = user
    }
    
    init(json: JSON) {
        self.text = json["comment"]["text"].string!
        self.user = User(apiAttributes: json["user"])
    }
    
    func saveInBackground(blog: Blog, completion: () -> Void) {
        let params: [String: AnyObject] = [
            "text": self.text,
            "user_id": self.user.id,
            "blog_id": blog.id
        ]
        
        Alamofire.request(.POST, String.rootPath() + "/api/comments", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                let commet = Comment(json: json)
                blog.comments.append(commet)
                completion()
        }
    }
}
