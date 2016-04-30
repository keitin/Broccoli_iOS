//
//  BlogImage.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class BlogImage: NSObject {
    var image: UIImage
    var imageURL: String!
    var order: Int
    
    init(image: UIImage, order: Int) {
        self.image = image
        self.order = order
    }
}
