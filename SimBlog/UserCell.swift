
//
//  UserCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/07.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(user: User) {
        profileImageView.sd_setImageWithURL(NSURL(string: user.imageURL))
        profileImageView.animateWith(0.5, fromAlpha: 0.5)
        nameLabel.text = user.name
    }
    
}
