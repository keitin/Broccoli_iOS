//
//  BlogCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

@objc protocol BlogCellDelegate {
    func didTapProfileImageView(blog: Blog)
}

class BlogCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: BlogCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gradientionView()
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
        setupSentenceLabel(blog.title)
        nameLabel.text = blog.user.name
        profileImageView.blog = blog
        profileImageView.sd_setImageWithURL(NSURL(string: blog.user.imageURL))
    }
    
    func layoutImageView() {
        profileImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(BlogCell.tapProfileImageView(_:)))
        profileImageView.makeCircle()
        profileImageView.lineBorderWhite()
        profileImageView.addGestureRecognizer(tap)
    }
    
    //MARK - Action
    func tapProfileImageView(sender: UITapGestureRecognizer) {
        let profileImageView = sender.view as! ProfileImageView
        delegate?.didTapProfileImageView(profileImageView.blog)
    }
    
    private func gradientionView() {
        let topColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:0.0)
        let bottomColor = UIColor(red:0, green:0, blue:0, alpha:0.6)
        let gradientColors = [topColor.CGColor, bottomColor.CGColor]
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.bounds
        self.topImageView.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    private func setupSentenceLabel(text: String) {
        
        let attributedText = NSMutableAttributedString(string: text)
        let letterSpacing = 1
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        attributedText.addAttribute(NSKernAttributeName, value: letterSpacing, range: NSMakeRange(0, attributedText.length))
        titleLabel.attributedText = attributedText
    }
    
}
