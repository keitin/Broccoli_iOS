//
//  BlogCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol BlogCellDelegate {
    func didTapProfileImageView(blog: Blog)
}

class BlogCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: BlogCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutImageView()
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
        sentenceLabel.text = blog.sentence
        nameLabel.text = blog.user.name
        profileImageView.blog = blog
        profileImageView.sd_setImageWithURL(NSURL(string: blog.user.imageURL))
    }
    
    func layoutImageView() {
        profileImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(BlogCell.tapProfileImageView(_:)))
        profileImageView.addGestureRecognizer(tap)
    }
    
    //MARK - Action
    func tapProfileImageView(sender: UITapGestureRecognizer) {
        let profileImageView = sender.view as! ProfileImageView
        delegate?.didTapProfileImageView(profileImageView.blog)
    }
    
}
