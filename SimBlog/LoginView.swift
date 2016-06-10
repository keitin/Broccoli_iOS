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
        makeLogoLabel()
        makeBorderView()
     }
    
    private func makeFacebookButton() {
        loginButton.center = self.center
        self.addSubview(loginButton)
    }
    
    private func makeLogoLabel() {
        let logoLabel = UILabel()
        logoLabel.text = "Simple Blog"
//        logoLabel.font = UIFont(name: "Baskerville-BoldItalic", size: 50)
        logoLabel.font = UIFont(name: "Helvetica-Light", size: 50)
        logoLabel.sizeToFit()
        logoLabel.center = CGPoint(x: self.center.x, y: self.center.y - 100)
        logoLabel.textColor = UIColor.white()
        self.addSubview(logoLabel)
    }
    
    private func makeBorderView() {
        let borderView = UIView()
        borderView.frame.size = CGSizeMake(self.frame.width - 30, 0.8)
        borderView.center = CGPoint(x: self.center.x, y: self.center.y - 60)
        borderView.backgroundColor = UIColor.white()
        self.addSubview(borderView)
    }
    

}
