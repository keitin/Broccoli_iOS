//
//  OwnSessionViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import SwiftyJSON

class OwnSessionViewModel: NSObject {
    var user: User!
    
    func loginSession(ownSessionView: OwnSessionView) {
        let json: JSON = [
            "email": ownSessionView.emailTextField.text!,
            "password": ownSessionView.passTextField.text!,
        ]
        self.user = User(ownSessionAttributes: json)
        self.user.saveAsSession { (user) in
            user.saveCurrentUserInLocal()
            let currentUser = CurrentUser.sharedInstance
            currentUser.getCurrentUserInLocal()
            UIApplication.redirectToInitialViewController()
        }
    }

}
