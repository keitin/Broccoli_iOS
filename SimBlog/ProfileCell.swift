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
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutProfileImage()
        layoutFollowButton()
        layoutFollowingButton()
        layoutFollowerButton()
        gradientionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
        lineBorderButton(borderWidth: 5)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(user: User) {
        if currentUser.id == user.id {
            followButton.hidden = true
        }
        
        if user.blocked {
            followerButton.enabled = false
            followingButton.enabled = false
            followButton.enabled = false
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
    private func layoutProfileImage() {
        profileImageView.contentMode = UIViewContentMode.ScaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderColor = UIColor.white().CGColor
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.masksToBounds = true
    }
    
    private func layoutFollowButton() {
        followButton.addTarget(self, action: #selector(ProfileCell.tapFollowButton(_:)), forControlEvents: .TouchUpInside)
        followButton.tintColor = UIColor.white()
        followButton.userInteractionEnabled = true
        followButton.setTitle("フォローする", forState: UIControlState.Normal)
        followButton.setTitle("フォロー中", forState: UIControlState.Selected)
    }
    
    private func layoutFollowingButton() {
        followingButton.setTitleColor(UIColor.white(), forState: .Normal)
        followingButton.addTarget(self, action: #selector(ProfileCell.tapFollowingButton(_:)), forControlEvents: .TouchUpInside)
    }
    
    private func layoutFollowerButton() {
        followerButton.setTitleColor(UIColor.white(), forState: .Normal)
        followerButton.addTarget(self, action: #selector(ProfileCell.tapFollowerButton(_:)), forControlEvents: .TouchUpInside)
    }
    
    private func gradientionView() {
        UIColor.mainColor()
        let topColor = UIColor(red: 237/255, green: 77/255, blue: 56/233, alpha:1.0)
        let bottomColor = UIColor(red: 245/255, green: 147/255, blue: 53/233, alpha:1.0)
        let gradientColors = [topColor.CGColor, bottomColor.CGColor]
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    private func lineBorderButton(borderWidth borderWidth: CGFloat) {
        let borderView = UIView()
        borderView.frame.size = CGSizeMake(self.frame.width, borderWidth)
        borderView.center = CGPointMake(self.center.x, self.frame.height)
        borderView.backgroundColor = UIColor.white()
        self.addSubview(borderView)
    }
}
