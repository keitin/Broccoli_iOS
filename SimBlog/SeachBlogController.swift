//
//  SeachBlogController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/08.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class SeachBlogController: UINavigationController, UITextFieldDelegate {

    var blogDisplayType: BlogDisplayType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Seach"
        self.navigationBar.translucent = false
        let indexBlogVC = UIStoryboard.viewControllerWith("Main", identifier: "IndexBlogViewController") as! IndexBlogViewController
        self.setViewControllers([indexBlogVC], animated: true)
        indexBlogVC.blogDisplayType = blogDisplayType
        
        let textFiled = SearchTextField(navigationBar: navigationBar)
        textFiled.delegate = self
        self.navigationBar.addSubview(textFiled)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TextField Delegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("はじめ！")
        return true
    }
}
