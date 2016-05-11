//
//  SearchTextField.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {
    
    required init(navigationBar: UINavigationBar) {
        super.init(frame: CGRectZero)
        setTextFiled(navigationBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextFiled(navigationBar: UINavigationBar) {
        self.frame.size.width = navigationBar.frame.width - 16
        self.frame.size.height = 28
        self.center = navigationBar.center
        self.borderStyle = .RoundedRect
        self.backgroundColor = UIColor.whiteColor()
        self.placeholder = "キーワードで検索"
        self.font = UIFont(name: "HiraKakuProN-W3", size: 13)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
     
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
