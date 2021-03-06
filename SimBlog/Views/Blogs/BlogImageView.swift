//
//  BlogImageView.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/14.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class BlogImageView: UIImageView {

    var blog: Blog!
    let textViewDefaultHeight: CGFloat = 200
    var height: CGFloat {
        return self.frame.height
    }
    
    init(y: CGFloat, view: UIView) {
        super.init(frame: CGRectZero)
        self.frame = CGRectMake(5, y, view.frame.width - 10, self.textViewDefaultHeight)
        self.image = UIImage(named: "bijo")
        self.backgroundColor = UIColor.lightGrayColor()
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 5
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
}
