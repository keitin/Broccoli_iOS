//
//  UIAlertAction+Extension.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/22.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertAction {
    class func blockAction(blocking: Bool, callback: () -> Void) -> UIAlertAction {
        var title: String!
        if blocking {
            title = Message.removeBlock
        } else {
            title = Message.block
        }
        let blockAction = UIAlertAction(title: title, style: .Default) { (action) in
            callback()
        }
        return blockAction
    }
}