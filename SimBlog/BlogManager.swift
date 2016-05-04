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
    func getBlogsInbackgroundWithBlock(user user: User?, callback: () -> Void) {
        Alamofire.request(.GET, String.rootPath() + "/api/blogs/?user_id=\(user?.id)", parameters: nil)
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
                    self.blogs.insert(blog, atIndex: 0)
                    callback()
                }
        }
    }
    
}
