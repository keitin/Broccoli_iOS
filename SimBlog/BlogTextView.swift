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
    var textViewDefaultHeight: CGFloat {
        if self.isTitle {
            return 50
        } else {
            return 100
        }
    }
    
    var fontSize: CGFloat {
        if self.isTitle {
            return 15
        } else {
            return 50
        }
    }
    
    init(y: CGFloat, view: UIView, isTitle: Bool, tag: Int) {
        super.init(frame: CGRectZero, textContainer: .None)
        self.isTitle = isTitle
        self.frame = CGRectMake(0, y, view.frame.width, self.textViewDefaultHeight)
        self.font = UIFont.systemFontOfSize(self.fontSize)
        self.scrollEnabled = false
        self.tag = tag
        self.layer.borderColor = UIColor.mainColor().CGColor
        self.layer.borderWidth = 3
        setPlaceholderLabel()
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
