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
    
    func loginSession(ownSessionView: OwnSessionView, completion: (message: String?) -> Void) {
        let json: JSON = [
            "email": ownSessionView.emailTextField.text!,
            "password": ownSessionView.passTextField.text!,
        ]
        self.user = User(ownSessionAttributes: json)
        self.user.saveAsSession { (user, message) in
            
            if let msg = message {
                completion(message: msg)
                return
            }

            user!.saveCurrentUserInLocal()
            let currentUser = CurrentUser.sharedInstance
            currentUser.initCurrentUser()
            currentUser.getCurrentUserInLocal()
            completion(message: nil)            
        }
    }

}
