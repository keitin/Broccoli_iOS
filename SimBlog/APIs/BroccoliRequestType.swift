//
//  BroccoliRequestType.swift
//  SimBlog
//
//  Created by 松下慶大 on 2017/01/13.
//  Copyright © 2017年 matsushita keita. All rights reserved.
//

import Foundation

protocol BroccoliRequestType: RequestType {}

extension BroccoliRequestType {
    var baseURL: String {
        return "http://52.68.152.185"
//        return "http://localhost:3000"
    }
}