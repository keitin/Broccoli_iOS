//
//  LoginView.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/28.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class LoginView: UIView {
    
    let loginButton = FBSDKLoginButton()
    
    class func instance() -> LoginView {
        return UINib(nibName: "LoginView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! LoginView
    }
    
     override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        makeFacebookButton()
     }
    
    func makeFacebookButton() {
        loginButton.center = self.center
        self.addSubview(loginButton)
    }

}
