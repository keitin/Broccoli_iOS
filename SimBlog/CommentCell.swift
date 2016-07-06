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
        self.layoutIconImageView()
        self.layoutCommentLabel()
        self.layoutNameLabel()
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
        self.commentLabel.textColor = UIColor.maingGray()
        self.commentLabel.font = UIFont.systemFontOfSize(11)
    }
    
    private func layoutIconImageView() {
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.width / 2
    }
    
    private func layoutNameLabel() {
        self.nameLabel.font = UIFont.systemFontOfSize(11)
        self.nameLabel.textColor = UIColor.blackColor()
    }
    
    
}
