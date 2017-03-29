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
    let gradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        gradientionView()
        layoutImageView()
        lineBorderButton(borderWidth: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(blog: Blog) {
        topImageView.image = blog.topImage
        if let topImageURL = blog.topImageURL {
            // トップ画像を優先して取得
            topImageView.sd_setImageWithURL(NSURL(string: topImageURL),
                                            placeholderImage: UIImage(),
                                            options: .HighPriority)
        }
        profileImageView.sd_setImageWithURL(NSURL(string: blog.user.imageURL),
                                            placeholderImage: UIImage(named: "icon"),
                                            options: .LowPriority)
        setupSentenceLabel(blog.title)
        nameLabel.text = blog.user.name
        profileImageView.blog = blog
        topImageView.animateWith(1.0, fromAlpha: 0.8)
        profileImageView.animateWith(1.0, fromAlpha: 0.8)
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
        let bottomColor = UIColor(red:0, green:0, blue:0, alpha:0.4)
        let gradientColors = [topColor.CGColor, bottomColor.CGColor]
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
    
    private func lineBorderButton(borderWidth borderWidth: CGFloat) {
        let borderView = UIView()
        borderView.frame.size = CGSizeMake(self.frame.width, borderWidth)
        borderView.center = CGPointMake(self.center.x, self.frame.height)
        borderView.backgroundColor = UIColor.white()
        self.addSubview(borderView)
    }
    
    /*画像が画面から消える時にまだ画像をダウンロードしていたらリクエストをキャンセルする*/
    override func prepareForReuse() {
        super.prepareForReuse()
        self.topImageView.sd_cancelCurrentImageLoad()
    }
    
}
