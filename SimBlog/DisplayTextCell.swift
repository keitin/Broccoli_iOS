//
//  DisplayTextCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class DisplayTextCell: UITableViewCell {
    @IBOutlet weak var sentenceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWith(blogText: BlogText) {
        setupSentenceLabel(blogText.text)
    
    }
    
    private func setupSentenceLabel(text: String) {
        
        let attributedText = NSMutableAttributedString(string: text)
        let letterSpacing = 1
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        attributedText.addAttribute(NSKernAttributeName, value: letterSpacing, range: NSMakeRange(0, attributedText.length))
        print("1111111111")
        sentenceLabel.attributedText = attributedText
        print("22222222222")
    }
    
}
