//
//  OwnLoginViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SwiftyJSON

class OwnLoginViewModel: NSObject {
    
    var user: User!
    
    func login(ownLoginView: OwnLoginView) {
        let attributes: [String: AnyObject] = [
            "name": ownLoginView.nameTextField.text!,
            "email": ownLoginView.emailTextField.text!,
            "password": ownLoginView.passTextField.text!,
            "image": ownLoginView.iconImageView.image!
        ]
        self.user = User(ownLoginAttributes: attributes)
        self.user.issueToken()
        self.user.saveAsOwnLogin {
            self.user.saveCurrentUserInLocal()
            let currentUser = CurrentUser.sharedInstance
            currentUser.getCurrentUserInLocal()
            UIApplication.redirectToInitialViewController()
        }
    }

}
