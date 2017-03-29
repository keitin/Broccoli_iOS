//
//  DeleteHistoryCell.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class DeleteHistoryCell: UITableViewCell {
    @IBOutlet weak var deleteHistoryButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setDeleteButton()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDeleteButton() {
        deleteHistoryButton.addTarget(self, action: #selector(DeleteHistoryCell.tapDeleteButton(_:)), forControlEvents: .TouchUpInside)
    }
    
    func tapDeleteButton(sender: UIBarButtonItem) {
        
    }
    
}
