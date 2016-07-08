//
//  IndexCommentViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/07/06.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class IndexCommentViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    let indexCommentViewModel = IndexCommentViewModel()
    var blog: Blog!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.indexCommentViewModel.didLoad(self.blog, tableView: self.tableView)
        self.keyboardNotification()
        self.setTextFiled()
        self.setPostButton()
        self.setBottomView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func keyboardNotification() {
        //Keyboard Notification
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.keyboardWillShow(self, selector: #selector(IndexCommentViewController.showWillKeyboard(_:)))
        notificationCenter.keyboardWillHide(self, selector: #selector(IndexCommentViewController.hideWillKeyboard(_:)))
    }
    
    //MARK: TextFiled Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.indexCommentViewModel.postComment(self.blog, text: self.commentTextField.text!)
        
        self.commentTextField.endEditing(true)
        self.commentTextField.text = ""
        return true
    }
    
    //MARK: Actions
    func tappedPostButton(sender: UIButton) {
        
        self.indexCommentViewModel.postComment(self.blog, text: self.commentTextField.text!)
        
        self.commentTextField.endEditing(true)
        self.commentTextField.text = ""
    }
    
    private func setTextFiled() {
        self.commentTextField.delegate = self
    }
    
    private func setBottomView() {
        self.bottomView.layer.lineBorderTop(borderWidth: 0.5, color: UIColor.lightGrayColor())
    }
    
    private func setPostButton() {
        self.postButton.addTarget(self, action: #selector(IndexCommentViewController.tappedPostButton(_:)), forControlEvents: .TouchUpInside)
        self.postButton.setTitleColor(UIColor.mainColor(), forState: .Normal)
    }
    
    //MARK: Keyborad Notification
    func showWillKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo{
            if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue{
                let keyboardRect = keyboard.CGRectValue()
                self.bottomMargin.constant = keyboardRect.height
            }
        }
    }
    
    func hideWillKeyboard(notification: NSNotification) {
        UIView.animateWithDuration(2.5, animations: {
            self.bottomMargin.constant = 0
        })
    }

}
