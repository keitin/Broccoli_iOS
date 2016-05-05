//
//  BlogManager.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class BlogManager: NSObject {
    static let sharedInstance = BlogManager()
    var blogs: [Blog] = []
    var numberOfBlogs: Int {
        return blogs.count
    }
    
    override init() {
        super.init()
    }
    
    func addBlogAtPosition(blog: Blog, index: Int) {
        blogs.insert(blog, atIndex: index)
    }
    
    func blogAtPosition(index: Int) -> Blog {
        return blogs[index]
    }
    
    //API
    func getBlogsInbackgroundWithBlock(user user: User?, page: Int, callback: () -> Void) {
        SVProgressHUD.show()
        let params = [
            "page": page
        ]
        Alamofire.request(.GET, String.rootPath() + "/api/blogs/?user_id=\(user?.id)", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    print("えらー")
                    print(response)
                    return
                }
                let json = JSON(object)
                SVProgressHUD.dismiss()
                for object in json["blogs"].array! {
                    let blog = Blog(apiAttributes: object["blog"])
                    blog.user = User(apiAttributes: object["user"])
                    self.blogs.insert(blog, atIndex: self.numberOfBlogs)
                    callback()
                }
        }
    }
    
}
