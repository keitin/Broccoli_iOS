//
//  SearchTextFiled.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class SearchTextFiled: UITextField, UITextFieldDelegate {
    
    
//    required init(navigationBar: UINavigationBar) {
//        super.init(frame: CGRectZero)
//        self.frame.size.width = navigationBar.frame.width - 16
//        self.frame.size.height = 28
//        self.center = navigationBar.center
//        setTextField()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func drawRect(rect: CGRect) {
        self.placeholder = "タイトルを検索"
    }

    func setTextField() {
        self.borderStyle = .RoundedRect
        self.placeholder = "タイトルを検索"
        self.backgroundColor = UIColor.whiteColor()
    }
    
}
