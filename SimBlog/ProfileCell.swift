//
//  ProfileCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/04.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutProfileImage()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(user: User) {
        nameLabel.text = user.name
        profileImageView.sd_setImageWithURL(NSURL(string: user.imageURL))
    }
    
    //MARK - Layout Sub Views
    func layoutProfileImage() {
        profileImageView.contentMode = UIViewContentMode.ScaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.masksToBounds = true
    }
    
}
