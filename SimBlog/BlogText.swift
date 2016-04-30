//
//  BlogText.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class BlogText: NSObject {
    var text: String
    var order: Int
    
    init(text: String, order: Int) {
        self.text = text
        self.order = order
    }
}
