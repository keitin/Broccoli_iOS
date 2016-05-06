//
//  ProfileCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/04.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol ProfileCellDelegate {
    func didTappedFollowButton(button: UIButton)
}

class ProfileCell: UITableViewCell {
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var delegate: ProfileCellDelegate?
    let currentUser = CurrentUser.sharedInstance
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutProfileImage()
        layoutFollowButton()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(user: User) {
        if currentUser.id == user.id {
            followButton.hidden = true
        }
        nameLabel.text = user.name
        profileImageView.sd_setImageWithURL(NSURL(string: user.imageURL))
        currentUser.isFollow(user) { (isFollow) in
            self.followButton.selected = isFollow
        }
    }
    
    //MARK - Action
    func tapFollowButton(sender: UIButton) {
        delegate?.didTappedFollowButton(sender)
    }
    
    //MARK - Layout Sub Views
    func layoutProfileImage() {
        profileImageView.contentMode = UIViewContentMode.ScaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.masksToBounds = true
    }
    
    func layoutFollowButton() {
        followButton.addTarget(self, action: #selector(ProfileCell.tapFollowButton(_:)), forControlEvents: .TouchUpInside)
        followButton.userInteractionEnabled = true
        followButton.setTitle("Follow", forState: UIControlState.Normal)
        followButton.setTitle("UnFollow", forState: UIControlState.Selected)
    }
    
}
