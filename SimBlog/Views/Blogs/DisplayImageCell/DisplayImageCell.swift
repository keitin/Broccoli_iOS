//
//  DisplayImageCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

class DisplayImageCell: UITableViewCell {
    @IBOutlet weak var blogImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setBlogImageView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(blogImage: BlogImage) {
        if let image = blogImage.image {
            self.blogImageView.image = image
        } else {
            self.blogImageView.sd_setImageWithURL(NSURL(string: blogImage.imageURL))
        }
    }
    
    private func setBlogImageView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(DisplayImageCell.tapImageView(_:)))
        self.blogImageView.userInteractionEnabled = true
        self.blogImageView.addGestureRecognizer(gesture)
    }
    
    func tapImageView(sender: UITapGestureRecognizer) {
        
        let view = self.superview?.superview?.superview?.superview
        
        let tmpImageView = sender.view as! UIImageView
        let backgroundView = self.createBackgroundView(view!)
        view!.addSubview(backgroundView)
        
        let largeImageView = UIImageView(image: tmpImageView.image)
        largeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        largeImageView.layer.masksToBounds = true
        backgroundView.addSubview(largeImageView)
        
        let frame = backgroundView.convertRect(tmpImageView.frame, fromView: self)
        largeImageView.frame = frame
        
        largeImageView.frame.size = view!.frame.size
        largeImageView.center = view!.center
        largeImageView.contentMode = UIViewContentMode.ScaleAspectFit

    }
    
    func tapBackgroundView(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    private func createBackgroundView(view: UIView) -> UIView {
        let backgroundView = UIView(frame: view.frame)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(DisplayImageCell.tapBackgroundView(_:)))
        backgroundView.addGestureRecognizer(gesture)
        backgroundView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        return backgroundView
    }
    

    
}
