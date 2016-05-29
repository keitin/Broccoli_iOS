//
//  UICollectionView+Extenstion.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/19.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCell(cellName: String) {
        self.registerNib(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }
}