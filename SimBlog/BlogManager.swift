//
//  BlogManager.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class BlogManager: NSObject {
    static let sharedInstance = BlogManager()
    var blogs: [Blog] = []
    var numberOfBlogs: Int {
        return blogs.count
    }
    
    override init() {
        super.init()
        let blog = Blog()
        blog.title = "ほげほげほげほげほげ"
        blog.topImage = UIImage(named: "image1.png")
        addBlogAtPosition(blog, index: 0)
        
        let blog1 = Blog()
        blog1.title = "ほげほげほげほげほげ"
        blog1.topImage = UIImage(named: "image1.png")
        addBlogAtPosition(blog1, index: 0)
        
        let blog2 = Blog()
        blog2.title = "ほげほげほげほげほげ"
        blog2.topImage = UIImage(named: "image1.png")
        addBlogAtPosition(blog2, index: 0)
        
        let blog3 = Blog()
        blog3.title = "ほげほげほげほげほげ"
        blog3.topImage = UIImage(named: "image1.png")
        addBlogAtPosition(blog3, index: 0)
    }
    
    func addBlogAtPosition(blog: Blog, index: Int) {
        blogs.insert(blog, atIndex: index)
    }
    
    func blogAtPosition(index: Int) -> Blog {
        return blogs[index]
    }
}
