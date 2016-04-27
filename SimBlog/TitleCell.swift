//
//  TitleCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

@objc protocol TitleCellDelegate {
    func titleTextViewDidBeginEditing(textView: UITextView)
    func titleTextViewDidChange(textView: UITextView)
}

class TitleCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    var delegate: TitleCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK - Set Up Sub Views
    private func setupTextView() {
        titleTextView.scrollEnabled = false
        titleTextView.delegate = self
    }
    
    func fillWith(blog: Blog) {
        titleTextView.text = blog.title
    }
    
    //MARK TextView Delegate
    func textViewDidChange(textView: UITextView) {
        delegate?.titleTextViewDidChange(textView)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        placeholderLabel.hidden = true
    }
    
    
    
}
