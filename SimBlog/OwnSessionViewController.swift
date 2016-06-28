//
//  OwnSessionViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class OwnSessionViewController: UIViewController {
    
    let ownSessionViewModel = OwnSessionViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = OwnSessionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Delete-50"), style: .Done, target: self, action: #selector(OwnSessionViewController.close(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ログイン", style: .Done, target: self, action: #selector(OwnSessionViewController.sessionUser(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func close(sender: UINavigationItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sessionUser(sender: UINavigationItem) {
        let ownSessionView = self.view as! OwnSessionView
        if let message = ownSessionView.validateForm() {
            let alert = UIAlertController.okAlert(message)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        self.ownSessionViewModel.loginSession(ownSessionView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
