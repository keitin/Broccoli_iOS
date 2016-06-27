//
//  OwnLoginViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/24.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class OwnLoginViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let ownLoginViewModel = OwnLoginViewModel()
    var iconImage: UIImage?
    
    override func loadView() {
        super.loadView()
        self.view = OwnLoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeDelegateInTextField()
        let ownLoginView = self.view as! OwnLoginView
        ownLoginView.selectImageButton.addTarget(self, action: #selector(OwnLoginViewController.tapSelectImageButton(_:)), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Delete-50"), style: .Done, target: self, action: #selector(OwnLoginViewController.close(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登録", style: .Done, target: self, action: #selector(OwnLoginViewController.tapLoginButton(_:)))
        ownLoginView.tapView.addTarget(self, action: #selector(OwnLoginViewController.tapView(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Image Picker
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let ownLoginView = self.view as! OwnLoginView
        ownLoginView.iconImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.iconImage = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Action
    func tapSelectImageButton(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let album = UIImagePickerController()
            album.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            album.delegate = self
            album.allowsEditing = true
            self.presentViewController(album, animated: true, completion: nil)
        }
    }
    
    func tapLoginButton(sender: UINavigationItem) {
        let ownLoginView = self.view as! OwnLoginView
        if let message = ownLoginView.validateForm(self.iconImage) {
            let alert = UIAlertController.okAlert(message)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        self.ownLoginViewModel.login(ownLoginView)
    }
    
    func tapView(sender: UITapGestureRecognizer) {
        let ownLoginView = self.view as! OwnLoginView
        ownLoginView.closeKeyboard()
    }
    
    func close(sender:UINavigationItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func makeDelegateInTextField() {
        let ownLoginView = self.view as! OwnLoginView
        ownLoginView.nameTextField.delegate = self
        ownLoginView.emailTextField.delegate = self
        ownLoginView.passTextField.delegate = self
        ownLoginView.confirmPassTextField.delegate = self
    }

}
