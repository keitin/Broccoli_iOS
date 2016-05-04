//
//  DisplayImageCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

class DisplayImageCell: UITableViewCell {
    @IBOutlet weak var blogImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(blogImage: BlogImage) {
        if let image = blogImage.image {
            blogImageView.image = image
        } else {
            blogImageView.sd_setImageWithURL(NSURL(string: blogImage.imageURL))
        }
    }
    
}
