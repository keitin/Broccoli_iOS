//
//  BlogImageCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/19.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SDWebImage

class BlogImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: BlogImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutImageView()
    }
    
    func fillWith(blog: Blog) {
        imageView.sd_setImageWithURL(NSURL(string: blog.topImageURL!))
        imageView.animateWith(1.0, fromAlpha: 0.5)
        imageView.blog = blog
    }
    
    private func layoutImageView() {
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.userInteractionEnabled = true
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(BlogImageCell.pressLongImage(_:)))
        imageView.addGestureRecognizer(longPressGesture)
    }
    
    func pressLongImage(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizerState.Began {
            
            let view = self.superview?.superview?.superview
            let selectImageView = gesture.view as! BlogImageView
            let backgroundView = self.createBackgroundView(view!)
            
            let largeImageView = BlogImageView(image: selectImageView.image)

            let frame = backgroundView.convertRect(selectImageView.frame, fromView: self)
            largeImageView.frame = frame
            largeImageView.contentMode = UIViewContentMode.ScaleAspectFill
            largeImageView.blog = selectImageView.blog
            backgroundView.addSubview(largeImageView)
            
            UIView.animateWithDuration(0.2, animations: {
                largeImageView.frame.size = backgroundView.frame.size
                largeImageView.center = backgroundView.center
                largeImageView.contentMode = UIViewContentMode.ScaleAspectFit
            })
        }
    }
    
    private func createBackgroundView(view: UIView) -> UIView {
        
        let backgroundView = UIView(frame: view.frame)
        backgroundView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(BlogImageCell.tapBackgroundView(_:)))
        backgroundView.addGestureRecognizer(gesture)
        view.addSubview(backgroundView)
        return backgroundView
    }
    
    func tapBackgroundView(gesture: UITapGestureRecognizer) {
        gesture.view?.removeFromSuperview()
    }
    

}
