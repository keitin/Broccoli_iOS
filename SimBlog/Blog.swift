//
//  Blog.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class Blog: NSObject {
    var materials: [AnyObject] = []
    var title: String! = ""
    var sentence: String! = ""
    var topImage: UIImage?
    var numberOfMaterials: Int {
        return materials.count
    }
    
    override init() {
        super.init()
        addTextAtPosition("", index: 0)
    }
    
    func addTextAtPosition(text: String, index: Int) {
        materials.insert(BlogText(text: text), atIndex: index)
    }
    
    func addImageAtPostion(image: UIImage, index: Int) {
        materials.insert(BlogImage(image: image), atIndex: index)
    }
    
    func materialAtPosition(index: Int) -> AnyObject {
        return materials[index]
    }
    
}
