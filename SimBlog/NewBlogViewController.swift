//
//  ViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class NewBlogViewController: UIViewController, UIImagePickerControllerDelegate ,UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var toolViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    var barHeight: CGFloat!
    var statusBarHeight: CGFloat!
    
    let blogEditorViewModel = BlogEditorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Blog"
        blogEditorViewModel.numberOfMaterials = 0
        
        self.barHeight = self.navigationController?.navigationBar.frame.height
        self.statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        // Scroll View Set
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.size.height - self.barHeight  - self.statusBarHeight)
        
        // first TextView set
        let titleTextView = BlogTextView(y: 0, view: self.view, isTitle: true,
                                         tag: blogEditorViewModel.numberOfMaterials)
        blogEditorViewModel.titleTextView = titleTextView
        titleTextView.delegate = self
        self.scrollView.addSubview(titleTextView)
        
        let textView = BlogTextView(y: blogEditorViewModel.heightOfAllMaterials(self.view),
                                    view: self.view,
                                    isTitle: false,
                                    tag: blogEditorViewModel.numberOfMaterials)
        textView.delegate = self
        blogEditorViewModel.textViews.append(textView)
        self.scrollView.addSubview(textView)

        
        
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
    
    // TextView Delegate
    func textViewDidChange(textView: UITextView) {
        let blogTextView = textView as! BlogTextView
        blogTextView.hideOrShowPlaceholderLabel()
        blogTextView.updateBorderViewPosition()
        blogEditorViewModel.updateTextViewText(blogTextView)
        blogEditorViewModel.updateTextViewHeight(blogTextView, viewController: self)
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        blogEditorViewModel.updateTextViewHeight(textView as! BlogTextView, viewController: self)
        blogEditorViewModel.updateScrooViewContentSize(self.scrollView, view: self.view)
        return true
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
        let textView = BlogTextView(y: blogEditorViewModel.heightOfAllMaterials(self.view), view: self.view, isTitle: false, tag: blogEditorViewModel.numberOfMaterials)
        textView.delegate = self
        textView.becomeFirstResponder()
        blogEditorViewModel.addTextViewToArray(textView)
        blogEditorViewModel.updateScrooViewContentSize(self.scrollView, view: self.view)
        self.scrollView.addSubview(textView)
        self.scrollView.contentSize.height = self.scrollView.contentSize.height
        blogEditorViewModel.scrollToEnd(self.scrollView)
    }
    
    @IBAction func tapDoneButton(sender: UIButton) {
        for textView in blogEditorViewModel.textViews {
            textView.resignFirstResponder()
        }
    }
    
    func postBlog(sender: UIBarButtonItem) {
        blogEditorViewModel.postBlog { (message) in
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
            let imageView = BlogImageView(y: blogEditorViewModel.heightOfAllMaterials(self.view), view: self.view)
            imageView.image = selectImage
            blogEditorViewModel.addImageViewToArray(imageView)
            blogEditorViewModel.updateScrooViewContentSize(self.scrollView, view: self.view)
            self.scrollView.addSubview(imageView)
            blogEditorViewModel.scrollToEnd(self.scrollView)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK Keyboard Notification
    func showWillKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo{
            if let keyboard = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue{
                let keyboardRect = keyboard.CGRectValue()
                self.toolViewBottomMargin.constant = keyboardRect.height
                self.scrollView.frame.size.height = self.scrollView.frame.height - keyboardRect.height
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

