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
        addBlogAtPosition(Blog(), index: 0)
        addBlogAtPosition(Blog(), index: 0)
        addBlogAtPosition(Blog(), index: 0)
    }
    
    func addBlogAtPosition(blog: Blog, index: Int) {
        blogs.insert(blog, atIndex: index)
    }
    
    func blogAtPosition(index: Int) -> Blog {
        return blogs[index]
    }
}
