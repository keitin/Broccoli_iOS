//
//  TextCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

@objc protocol TextCellDelegate {
    func textViewDidBeginEditing(textView: UITextView)
    func textViewDidChange(textView: UITextView)
}


class TextCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    var delegate: TextCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK - Set Up Sub Views
    private func setupTextView() {
        textView.scrollEnabled = false
        textView.delegate = self
    }
    
    // MARK - TextView Delegate
    func textViewDidBeginEditing(textView: UITextView) {
        placeholderLabel.hidden = true
        delegate?.textViewDidBeginEditing(textView)
    }
    
    func textViewDidChange(textView: UITextView) {
        delegate?.textViewDidChange(textView)
    }
    
}
