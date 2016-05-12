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
    func didTappedFollowerButton(button: UIButton)
    func didTappedFollowingButton(button: UIButton)
}

class ProfileCell: UITableViewCell, Follow {
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
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
        layoutFollowingButton()
        layoutFollowerButton()
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
        isFollow(currentUser, toUser: user) { (isFollow) in
            self.followButton.selected = isFollow
        }
    }
    
    //MARK - Button Action
    func tapFollowButton(sender: UIButton) {
        delegate?.didTappedFollowButton(sender)
    }
    
    func tapFollowingButton(sender: UIButton) {
        delegate?.didTappedFollowingButton(sender)
    }
    
    func tapFollowerButton(sender: UIButton) {
        delegate?.didTappedFollowerButton(sender)
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
        followButton.setTitle("フォローする", forState: UIControlState.Normal)
        followButton.setTitle("フォロー中", forState: UIControlState.Selected)
    }
    
    func layoutFollowingButton() {
        followingButton.addTarget(self, action: #selector(ProfileCell.tapFollowingButton(_:)), forControlEvents: .TouchUpInside)
    }
    
    func layoutFollowerButton() {
        followerButton.addTarget(self, action: #selector(ProfileCell.tapFollowerButton(_:)), forControlEvents: .TouchUpInside)
    }
    
}
