//
//  BlogImageCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/19.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

class BlogImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutImageView()
    }
    
    func fillWith(blog: Blog) {
        imageView.sd_setImageWithURL(NSURL(string: blog.topImageURL!))
        imageView.animateWith(1.0, fromAlpha: 0.5)
    }
    
    private func layoutImageView() {
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.layer.masksToBounds = true
    }

}
