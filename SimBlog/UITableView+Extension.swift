//
//  UITableView+Extension.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
extension UITableView {
    func registerCell(cellName: String) {
        self.registerNib(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
}
