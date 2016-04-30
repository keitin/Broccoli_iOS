//
//  DisplayTitleCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

class DisplayTitleCell: UITableViewCell {
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(blog: Blog) {
        topImageView.image = blog.topImage
        if let topImageURL = blog.topImageURL {
            topImageView.sd_setImageWithURL(NSURL(string: topImageURL))
        }
        titleLabel.text = blog.title
    }
    
}
