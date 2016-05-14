//
//  DisplayTitleCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage
import Bond

@objc protocol DisplayTitleCellDelegate {
    func didTapProfileImageView(blog: Blog)
    func didTapLikeButton(button: UIButton, blog: Blog)
    func didTapUnLikeButton(button: UIButton, blog: Blog)
}

class DisplayTitleCell: UITableViewCell, Like {
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: DisplayTitleCellDelegate?
    var selectedBlog: Blog!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutImageView()
        layoutLikeButton()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(blog: Blog) {
        isLike(blog) { (isLike) in
            self.likeButton.selected = isLike
        }
        topImageView.image = blog.topImage
        if let topImageURL = blog.topImageURL {
            topImageView.sd_setImageWithURL(NSURL(string: topImageURL))
        }
        blog.likesCount.observe { [weak self] (currentLikes) in
            self!.likeCountLabel.text = String(currentLikes)
        }
        profileImageView.blog = blog
        self.selectedBlog = blog
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
    
    func layoutLikeButton() {
        likeButton.setTitle("イイネ！", forState: .Normal)
        likeButton.setTitle("取り消す！", forState: .Selected)
        likeButton.addTarget(self, action: #selector(DisplayTitleCell.tapLikeButton(_:)), forControlEvents: .TouchUpInside)
    }
    
    //MARK: - Action
    func tapProfileImageView(sender: UITapGestureRecognizer) {
        let profileImageView = sender.view as! ProfileImageView
        delegate?.didTapProfileImageView(profileImageView.blog)
    }
    
    func tapLikeButton(sender: UIButton) {
        if likeButton.selected {
            delegate?.didTapUnLikeButton(sender, blog: self.selectedBlog)
        } else {
            delegate?.didTapLikeButton(sender, blog: self.selectedBlog)
        } 
    }
    
}
