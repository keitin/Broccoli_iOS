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
        blog.saveInbackground()
        blogs.insert(blog, atIndex: index)
    }
    
    func blogAtPosition(index: Int) -> Blog {
        return blogs[index]
    }
    
    //API
    func getBlogsInbackgroundWithBlock(callback: () -> Void) {
        Alamofire.request(.GET, String.rootPath() + "/api/blogs/", parameters: nil)
            .responseJSON { response in
                guard let object = response.result.value else {
                    print("えらー")
                    return
                }
                let json = JSON(object)
                for object in json["blogs"].array! {
                    let blog = Blog()
                    blog.title = object["title"].string
                    blog.sentence = object["sentence"].string
                    blog.topImageURL = object["image"].string
                    self.blogs.insert(blog, atIndex: 0)
                    callback()
                }
                
        }
    }
}
