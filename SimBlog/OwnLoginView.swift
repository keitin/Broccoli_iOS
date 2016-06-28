//
//  OwnLoginView.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class OwnLoginView: UIView {

    let iconImageView = UIImageView()
    let nameTextField = UITextField()
    let passTextField = UITextField()
    let confirmPassTextField = UITextField()
    let emailTextField = UITextField()
    let selectImageButton = UIButton()
    let margin: CGFloat = 20
    let tapView = UITapGestureRecognizer()
    let toLoginButton = UIButton()
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.white()
        self.layoutTextField(self.nameTextField, y: 25, placeholder: "名前")
        self.layoutTextField(self.emailTextField, y: 70, placeholder: "メールアドレス")
        self.layoutTextField(self.passTextField, y: 115, placeholder: "パスワード")
        self.layoutTextField(self.confirmPassTextField, y: 160, placeholder: "確認用パスワード")
        self.layoutIconImageView()
        self.layoutSelectImageButton()
        self.layoutToLoginButton()
        self.addGestureRecognizer(self.tapView)
        self.passTextField.secureTextEntry = true
        self.confirmPassTextField.secureTextEntry = true
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    func validateForm(iconImage: UIImage?) -> String? {
        if self.nameTextField.text!.isEmpty || self.passTextField.text!.isEmpty || self.confirmPassTextField.text!.isEmpty {
            return ErrorMessage.emptyField
        }
        if self.passTextField.text != self.confirmPassTextField.text {
            return ErrorMessage.noMatchField
        }
        
        guard let _ = iconImage else {
            return ErrorMessage.noImage
        }
        return nil
    }
    
    func closeKeyboard() {
        self.nameTextField.resignFirstResponder()
        self.passTextField.resignFirstResponder()
        self.confirmPassTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
    }
    
    private func layoutTextField(textField: UITextField, y: CGFloat, placeholder: String) {
        textField.frame.size.width = self.frame.size.width - margin
        textField.frame.size.height = 30
        textField.center = CGPoint(x: self.center.x, y: y)
        textField.placeholder = placeholder
        textField.font = UIFont.systemFontOfSize(12)
        self.addSubview(textField)
        
        textField.layer.lineBorderBottom(borderWidth: 0.5, color: UIColor.broccoli())
    }
    
    private func layoutIconImageView() {
        self.iconImageView.frame.size = CGSize(width: 50, height: 50)
        self.iconImageView.frame.origin = CGPoint(x: 10, y: 205)
        self.iconImageView.image = UIImage(named: "noimage")
        self.iconImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.width / 2
        self.iconImageView.layer.masksToBounds = true
        self.iconImageView.layer.borderWidth = 0.5
        self.iconImageView.layer.borderColor = UIColor.broccoli().CGColor
        self.addSubview(self.iconImageView)
    }
    
    private func layoutSelectImageButton() {
        self.selectImageButton.frame.size = CGSize(width: self.frame.width - self.iconImageView.frame.width - margin*2 + 10, height: 30)
        self.selectImageButton.frame.origin = CGPoint(x: self.iconImageView.frame.origin.x + self.iconImageView.frame.size.width + 10, y: self.iconImageView.center.y - 15)
        self.selectImageButton.backgroundColor = UIColor.broccoli()
        self.selectImageButton.setTitle("画像を選択する", forState: .Normal)
        self.selectImageButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.selectImageButton.layer.cornerRadius = 15
        self.addSubview(self.selectImageButton)
    }
    
    private func layoutToLoginButton() {
        self.toLoginButton.setTitle("ログイン画面へ", forState: .Normal)
        self.toLoginButton.sizeToFit()
        self.toLoginButton.frame.origin = CGPoint(x: self.frame.width - self.toLoginButton.frame.width + 10, y: self.selectImageButton.frame.origin.y + 30)
        self.toLoginButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.toLoginButton.setTitleColor(UIColor.broccoli(), forState: .Normal)
        self.addSubview(self.toLoginButton)
    }


}
