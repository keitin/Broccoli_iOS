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
import Bond

class LoginView: UIView {
    
    let loginButton = FBSDKLoginButton()
    let checkboxButton = UIButton()
    let termButton = UIButton()
    
    class func instance() -> LoginView {
        return UINib(nibName: "LoginView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! LoginView
    }
    
     override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        makeFacebookButton()
        makeLogoLabel()
        makeBorderView()
        makeCheckBoxButtotn()
        makeTermButton()
     }
    
    private func makeFacebookButton() {
        loginButton.enabled = false
        loginButton.frame.size = CGSizeMake(280, 50)
        loginButton.center = CGPointMake(self.center.x, self.center.y + 150)
        self.addSubview(loginButton)
    }
    
    private func makeLogoLabel() {
        let logoLabel = UILabel()
        logoLabel.text = "Broccoli"
//        logoLabel.font = UIFont(name: "Baskerville-BoldItalic", size: 50)
        logoLabel.font = UIFont(name: "SavoyeLetPlain", size: 50)
//        logoLabel.font = UIFont(name: "SnellRoundhand-Black", size: 50)
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
    
    private func makeCheckBoxButtotn() {
        self.checkboxButton.frame.size = CGSize(width: 30, height: 30)
        print(self.checkboxButton.frame)
        self.checkboxButton.center = CGPoint(x: self.center.x + 50, y: self.center.y + 200)
        self.checkboxButton.setImage(UIImage(named: "Unchecked-Checkbox-50"), forState: .Normal)
        self.checkboxButton.setImage(UIImage(named: "Checked-Checkbox 2-50"), forState: .Selected)
        self.checkboxButton.bnd_controlEvent
            .filter { $0 == UIControlEvents.TouchUpInside }
            .observe { e in
                self.loginButton.enabled = self.checkboxButton.selected ? true : false
        }
        self.addSubview(self.checkboxButton)
    }
    
    private func makeTermButton() {
        self.termButton.setTitle("利用規約", forState: .Normal)
        self.termButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        self.termButton.sizeToFit()
        self.termButton.center = CGPoint(x: self.center.x, y: self.center.y + 200)
        self.termButton.setTitleColor(UIColor.white(), forState: .Normal)
        self.addSubview(self.termButton)
    }

}
