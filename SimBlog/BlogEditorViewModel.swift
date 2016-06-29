//
//  BlogEditorViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/02.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SVProgressHUD

class BlogEditorViewModel: NSObject {
    
    let blog = Blog()
    let currentUser = CurrentUser.sharedInstance
    var titleTextViewY: CGFloat!
    var titleTextView: BlogTextView!
    var textViews: [BlogTextView] = []
    var imageViews: [BlogImageView] = []
    var count: Int = 0
    var numberOfMaterials: Int  {
        set(number) {
            self.count = 0
        }
        get {
            return self.count + 1
        }
    }
    
    override init () {
        super.init()
        self.numberOfMaterials = 0
    }
    
    func postBlog(callback: (message: String?) -> Void) {
        if blog.title == "" || blog.topImage == nil {
            callback(message: ErrorMessage.emptyTitleOrImage)
            return
        }
        SVProgressHUD.show()
        blog.saveInbackground {
            SVProgressHUD.dismiss()
            self.currentUser.addFollowingBlogAtPostion(self.blog, index: 0)
            self.currentUser.addBlogAtPosition(self.blog, index: 0)
            callback(message: nil)
        }
    }
    
    func heightOfAllMaterials(view: UIView) -> CGFloat {
        var sumHeight: CGFloat = self.titleTextViewY
        
        sumHeight = sumHeight + self.titleTextView.heightOfTextViewWithText(view)
        
        for textView in self.textViews {
            sumHeight = sumHeight + textView.heightOfTextViewWithText(view)
        }
        
        for imageView in self.imageViews {
            sumHeight = sumHeight + imageView.height
        }
        return sumHeight
    }
    
    func addTextViewToArray(textView: BlogTextView) {
        self.textViews.append(textView)
        self.blog.addTextAtPosition(textView.text)
    }
    
    func addImageViewToArray(imageView: BlogImageView) {
        self.imageViews.append(imageView)
        if blog.topImage == nil {
            blog.topImage = imageView.image
        }
        self.blog.addImageAtPosition(imageView.image!)
    }
    
    func textOfAllTextViews() {
        var text = ""
        for textView in self.textViews {
            text = text + "\n" + textView.text
        }
    }
    
    func updateScrooViewContentSize(scrollView: UIScrollView, view: UIView) {
        scrollView.contentSize.height = self.heightOfAllMaterials(view)
    }
    
    func updateTextViewText(textView: BlogTextView) {
        if textView.isTitle  {
            blog.title = textView.text
            return
        } else {
            if let blogText = blog.materialAtPosition(blog.numberOfMaterials - 1) as? BlogText {
                blogText.text = textView.text
            }
        }
    }
    
    func updateTextViewHeight(textView: BlogTextView, viewController: NewBlogViewController) {
        
        // デフォのTextViewの高さを超えた時
        if textView.heightOfTextViewWithText(viewController.view) > textView.textViewDefaultHeight {
            let newHeight = textView.heightOfTextViewWithText(viewController.view)
            UIView.animateWithDuration(0.5, animations: {
                self.updateLocationOfTextViews(textView, height: newHeight - textView.frame.height)
                textView.frame.size.height = newHeight
            })
        }
        
        // 表示領域を超えた時
        if self.heightOfAllMaterials(viewController.view) > (viewController.scrollView.frame.height - viewController.statusBarHeight) {
            UIView.animateWithDuration(0.5, animations: {
                viewController.scrollView.contentSize.height = self.heightOfAllMaterials(viewController.view)
            })
        }
    }
    
    func scrollToEnd(scrollView: UIScrollView) {
        if scrollView.contentSize.height > scrollView.frame.height {
            UIView.animateWithDuration(0.5) {
                scrollView.contentOffset = CGPointMake(0, scrollView.contentSize.height - scrollView.frame.height)
            }
        }
    }
    
    private func updateLocationOfTextViews(textView: UITextView, height: CGFloat) {
        
        let shouldMoveTextViews = self.shouldMoveTextViews(textView)
        let shoulfMoveImageViews = self.shouldMoveImageViews(textView)
        
        for shouldMoveTV in shouldMoveTextViews {
            shouldMoveTV.frame.origin.y = shouldMoveTV.frame.origin.y + height
        }
        
        for shoulMoveIV in shoulfMoveImageViews {
            shoulMoveIV.frame.origin.y = shoulMoveIV.frame.origin.y + height
        }
    }
    
    private func shouldMoveTextViews(textView: UITextView) -> [UITextView] {
        let currentTextViewPositionY = textView.frame.origin.y
        var sholdMoveTextViews: [UITextView] = []
        for tv in self.textViews {
            if tv.frame.origin.y > currentTextViewPositionY {
                sholdMoveTextViews.append(tv)
            }
        }
        return sholdMoveTextViews
    }
    
    private func shouldMoveImageViews(textView: UITextView) -> [BlogImageView] {
        let currentTextViewPositionY = textView.frame.origin.y
        var sholdMoveImageViews: [BlogImageView] = []
        for iv in self.imageViews {
            if iv.frame.origin.y > currentTextViewPositionY {
                sholdMoveImageViews.append(iv)
            }
        }
        return sholdMoveImageViews
    }


}
