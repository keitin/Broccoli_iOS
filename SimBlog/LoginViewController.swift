//
//  LoginViewController.swift
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
import SDWebImage
import VideoSplashKit

class LoginViewController: VideoSplashViewController {

    let loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
        let loginView = LoginView.instance()
        self.view = loginView
        loginViewModel.didLoad(loginView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupVideo() {
        if let path = NSBundle.mainBundle().pathForResource("askyfullofstarsmp4", ofType: "mp4") {
            let url = NSURL.fileURLWithPath(path)
            videoFrame = view.frame
            fillMode = .ResizeAspectFill
            alwaysRepeat = true
            restartForeground = true
            sound = false
            startTime = 0.0
            duration = 0.0
            alpha = 1.0
            backgroundColor = UIColor.blackColor()
            contentURL = url
        }
    }
       
}
