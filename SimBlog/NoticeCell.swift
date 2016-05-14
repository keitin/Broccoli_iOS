//
//  NoticeCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/14.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol NoticeCellDelegate {
    func didTapBlogImageView(blog: Blog)
    func didTapUserImageView(user: User)
}

class NoticeCell: UITableViewCell {
    @IBOutlet weak var blogImageView: BlogImageView!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var userImageView: ProfileImageView!
    var delegate: NoticeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutBlogImageView()
        layoutUserImageView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillwith(notice: Notice) {
        userImageView.sd_setImageWithURL(NSURL(string: notice.user.imageURL))
        userImageView.user = notice.user
        blogImageView.sd_setImageWithURL(NSURL(string: notice.blog.topImageURL!))
        blogImageView.blog = notice.blog
        descriptLabel.text = notice.text
    }
    
    private func layoutBlogImageView() {
        blogImageView.aspectFill()
        blogImageView.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(NoticeCell.tapBlogImageView(_:)))
        blogImageView.addGestureRecognizer(gesture)
    }
    
    private func layoutUserImageView() {
        userImageView.aspectFill()
        userImageView.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(NoticeCell.tapUserImageView(_:)))
        userImageView.addGestureRecognizer(gesture)
    }
    
    //MARK: Action
    func tapBlogImageView(sender: UITapGestureRecognizer) {
        let blogImageView = sender.view as! BlogImageView
        delegate?.didTapBlogImageView(blogImageView.blog)
    }
    
    func tapUserImageView(sender: UITapGestureRecognizer) {
        let userImageView = sender.view as! ProfileImageView
        delegate?.didTapUserImageView(userImageView.user)
    }
    
}
