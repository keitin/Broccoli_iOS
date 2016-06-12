//
//  BlogTextView.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/02.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class BlogTextView: UITextView {
    
    var isTitle: Bool = false
    var placeholderlabel: UILabel!
    var borderView: UIView!
    var textViewDefaultHeight: CGFloat {
        if self.isTitle {
            return 50
        } else {
            return 100
        }
    }
    
    var fontSize: CGFloat {
        if self.isTitle {
            return 17
        } else {
            return 15
        }
    }
    
    init(y: CGFloat, view: UIView, isTitle: Bool, tag: Int) {
        super.init(frame: CGRectZero, textContainer: .None)
        self.isTitle = isTitle
        self.frame = CGRectMake(0, y, view.frame.width, self.textViewDefaultHeight)
        self.font = UIFont.systemFontOfSize(self.fontSize)
        self.scrollEnabled = false
        self.tag = tag
        self.lineBorderButton(borderWidth: 1)
        self.setPlaceholderLabel()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func heightOfTextViewWithText(view: UIView) -> CGFloat {
        let textView = UITextView()
        textView.text = self.text
        textView.frame.size.width = view.frame.width
        textView.font = UIFont.systemFontOfSize(self.fontSize)
        textView.sizeToFit()
        return max(textView.frame.height, self.textViewDefaultHeight)
    }
    
    func hideOrShowPlaceholderLabel() {
        if self.text.isEmpty {
            self.placeholderlabel.hidden = false
        } else {
            self.placeholderlabel.hidden = true
        }
    }
    
    func updateBorderViewPosition() {
        UIView.animateWithDuration(0.5) { 
            self.borderView.center.y = self.frame.height
        }
    }
    
    private func lineBorderButton(borderWidth borderWidth: CGFloat) {
        self.borderView = UIView()
        self.borderView.frame.size = CGSizeMake(self.frame.width - 16, borderWidth)
        self.borderView.center = CGPointMake(self.center.x, self.frame.height)
        self.borderView.backgroundColor = UIColor.mainColor()
        self.addSubview(self.borderView)
    }
    
    private func setPlaceholderLabel() {
        self.placeholderlabel = UILabel()
        if isTitle {
            self.placeholderlabel.text = "タイトルを入力"
        } else {
            self.placeholderlabel.text = "本文を入力"
        }
        self.placeholderlabel.sizeToFit()
        self.placeholderlabel.frame.origin = CGPoint(x: 10, y: 10)
        self.placeholderlabel.textColor = UIColor.lightGrayColor()
        self.addSubview(self.placeholderlabel)
    }

}
