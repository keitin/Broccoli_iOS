//
//  ViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class NewBlogViewController: UIViewController, UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
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
        
        navigationItem.leftImageButtonItem("Delete-50@2x", target: self, action:  #selector(NewBlogViewController.closeNewBlog(_:)))
        navigationItem.rightImageButtonItem("send-52@2x", target: self, action: #selector(NewBlogViewController.postBlog(_:)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK - Action    
    @IBAction func tapAddImageButton(sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let album = UIImagePickerController()
            album.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            album.allowsEditing = true
            album.delegate = self
            self.presentViewController(album, animated: true, completion: nil)
        }
    }

    @IBAction func tapAddTextButton(sender: UIButton) {
        newBlogViewModel.addText()
    }
    
    @IBAction func tapDoneButton(sender: UIButton) {
        newBlogViewModel.didFinishedEdit()
    }
    
    func postBlog(sender: UIBarButtonItem) {
        newBlogViewModel.postBlog { (message) in
            guard let error = message else {
                self.dismissViewControllerAnimated(true, completion: nil)
                return
            }
            let alert = UIAlertController.okAlert(error)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //MARK - Camera Roll
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let selectImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newBlogViewModel.addImage(selectImage)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK Keyboard Notification
    func showWillKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo{
            if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue{
                let keyBoardRect = keyboard.CGRectValue()
                UIView.animateWithDuration(1.0, animations: {
                    self.toolViewBottomMargin.constant = keyBoardRect.height + 20
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

