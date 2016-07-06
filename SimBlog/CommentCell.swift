//
//  CommentCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/07/06.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

class CommentCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    let minHeight: CGFloat = 80

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(comment: Comment) {
        self.nameLabel.text = comment.user.name
        self.commentLabel.text = comment.text
        self.iconImageView.sd_setImageWithURL(NSURL(string: comment.user.imageURL))
    }
    
    //MARK: Layout Sub Views
    private func layoutCommentLabel() {
        
    }
    
    
}
