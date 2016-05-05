//
//  DisplayTitleCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol DisplayTitleCellDelegate {
    func didTapProfileImageView(blog: Blog)
}

class DisplayTitleCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: DisplayTitleCellDelegate?
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
        profileImageView.blog = blog
        profileImageView.sd_setImageWithURL(NSURL(string: blog.user.imageURL))
        nameLabel.text = blog.user.name
        titleLabel.text = blog.title
    }
    
    //MARK - Layout Sub Views
    func layoutImageView() {
        profileImageView.layer.cornerRadius = 5
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.borderWidth = 2
        profileImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(DisplayTitleCell.tapProfileImageView(_:)))
        profileImageView.addGestureRecognizer(tap)
    }
    
    func tapProfileImageView(sender: UITapGestureRecognizer) {
        let profileImageView = sender.view as! ProfileImageView
        delegate?.didTapProfileImageView(profileImageView.blog)
    }
}
