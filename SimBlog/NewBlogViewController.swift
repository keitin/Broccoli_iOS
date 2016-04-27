//
//  ViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class NewBlogViewController: UIViewController {
    @IBOutlet weak var toolViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    let newBlogViewModel = NewBlogViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Blog"
        
        newBlogViewModel.didLoad(tableView)
        
        //Keyboard Notification
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.keyboardWillShow(self, selector: #selector(NewBlogViewController.showWillKeyboard(_:)))
        notificationCenter.keyboardWillHide(self, selector: #selector(NewBlogViewController.hideWillKeyboard(_:)))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .Done, target: self, action: #selector(NewBlogViewController.closeNewBlog(_:)))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK - Action
    @IBAction func tapAddImageButton(sender: UIButton) {
        newBlogViewModel.addImage()
    }

    @IBAction func tapAddTextButton(sender: UIButton) {
        newBlogViewModel.addText()
    }
    
    @IBAction func tapDoneButton(sender: UIButton) {
        newBlogViewModel.didFinishedEdit()
    }
    
    // MARK Keyboard Notification
    func showWillKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo{
            if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue{
                let keyBoardRect = keyboard.CGRectValue()
                UIView.animateWithDuration(1.0, animations: {
                    self.toolViewBottomMargin.constant = keyBoardRect.height
                })
            }
        }
    }
    
    func hideWillKeyboard(notification: NSNotification) {
        UIView.animateWithDuration(2.5, animations: {
            self.toolViewBottomMargin.constant = 0
        })
    }
    
    //MARK - Segue
    func closeNewBlog(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(false, completion: nil)
    }
}

