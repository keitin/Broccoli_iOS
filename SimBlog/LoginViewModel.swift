//
//  LoginViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/28.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import SwiftyJSON

class LoginViewModel: NSObject, FBSDKLoginButtonDelegate {
    
    func didLoad(loginView: LoginView) {
        loginView.loginButton.delegate = self
        loginView.loginButton.readPermissions = ["public_profile", "email"]
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        guard error == nil else {
            print("Error: \(error)")
            return
        }
        if result.isCancelled {
            print("Cancelled")
        } else {
            print("Logged in")
            getUserData()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("Logout");
    }
    
    private func getUserData(){
        let params = ["fields": "id, name, picture.type(large), photos, email"]
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphRequest.startWithCompletionHandler({ (connection, result, error) in
            guard error == nil && result != nil else{
                print("Error: \(error)")
                return
            }
            let json = JSON(result)
            let user = User(facebookAttributes: json)
            user.issueToken()
            user.saveInbackground({ 
                user.saveCurrentUserInLocal()
                let currentUser = CurrentUser.sharedInstance
                currentUser.getCurrentUserInLocal()
                UIApplication.redirectToInitialViewController()
            })
        })
    }
}
