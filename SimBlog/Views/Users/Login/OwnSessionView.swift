//
//  OwnSessionView.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class OwnSessionView: UIView {

    let emailTextField = UITextField()
    let passTextField = UITextField()
    let margin: CGFloat = 20
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func validateForm() -> String? {
        if self.emailTextField.text!.isEmpty || self.passTextField.text!.isEmpty  {
            return ErrorMessage.emptyField
        }
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.white()
        self.layoutTextField(self.emailTextField, y: 30, placeholder: "メールアドレス")
        self.layoutTextField(self.passTextField, y: 80, placeholder: "パスワード")
        self.passTextField.secureTextEntry = true
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
    
}
