//
//  SearchTextFiled.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class SearchTextFiled: UITextField, UITextFieldDelegate {
    
    override func drawRect(rect: CGRect) {
        self.placeholder = "タイトルを検索"
        self.clearButtonMode = UITextFieldViewMode.Always
    }

}
