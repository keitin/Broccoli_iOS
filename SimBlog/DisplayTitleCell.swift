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
}

class DisplayTitleCell: UITableViewCell, Like {
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: DisplayTitleCellDelegate?
    var selectedBlog: Blog!
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutImageView()
        gradientionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineBorderButton(borderWidth: 1)
        gradientLayer.frame = self.bounds
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
        blog.likesCount.observe { [weak self] (currentLikes) in
            self!.likeCountLabel.text = String(currentLikes)
        }
        profileImageView.blog = blog
        self.selectedBlog = blog
        profileImageView.sd_setImageWithURL(NSURL(string: blog.user.imageURL))
        nameLabel.text = blog.user.name
        setupSentenceLabel(blog.title)
        
        self.topImageView.animateWith(1.0, fromAlpha: 0.0)
    }
    
    //MARK - Layout Sub Views
    func layoutImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.borderWidth = 1
        profileImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(DisplayTitleCell.tapProfileImageView(_:)))
        profileImageView.addGestureRecognizer(tap)
    }
    
    //MARK: - Action
    func tapProfileImageView(sender: UITapGestureRecognizer) {
        let profileImageView = sender.view as! ProfileImageView
        delegate?.didTapProfileImageView(profileImageView.blog)
    }
    
    private func gradientionView() {
        UIColor.mainColor()
        let topColor = UIColor(red: 237/255, green: 77/255, blue: 56/233, alpha:0.2)
        let bottomColor = UIColor(red: 245/255, green: 147/255, blue: 53/233, alpha:0.5)
        let gradientColors = [topColor.CGColor, bottomColor.CGColor]
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.bounds
        self.topImageView.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    private func lineBorderButton(borderWidth borderWidth: CGFloat) {
        let borderView = UIView()
        borderView.frame.size = CGSizeMake(self.frame.width - 16, borderWidth)
        borderView.center = CGPointMake(self.center.x, self.frame.height)
        borderView.backgroundColor = UIColor.mainColor()
        self.addSubview(borderView)
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
