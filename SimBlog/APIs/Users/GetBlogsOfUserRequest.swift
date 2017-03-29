//
//  GetBlogsOfUserRequest.swift
//  SimBlog
//
//  Created by 松下慶大 on 2017/01/13.
//  Copyright © 2017年 matsushita keita. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct GetBlogsOfUserRequest: BroccoliRequestType {
    
    typealias Response = [Blog]
    
    var method: Alamofire.Method {
        return .GET
    }
    
    var path: String {
        return "/api/blogs/?user_id=\(user.id)"
    }
    
    var parameters: [String : AnyObject]? {
        return ["page": self.page]
    }
    
    var user: User
    var page: Int
    
    init(user: User, page: Int) {
        self.user = user
        self.page = page
    }
    
    func responseFromObject(response: Alamofire.Result<AnyObject, NSError>, completion: (response: Alamofire.Result<Response, NSError>) -> Void) {
        switch response {
        case .Success(let value):
            let json = JSON(value)
            var blogs: [Blog] = []
            for object in json["blogs"].array! {
                let blog = Blog(apiAttributes: object["blog"])
                blog.user = User(apiAttributes: object["user"])
                blogs.append(blog)
            }
            completion(response: Result.Success(blogs))
        case .Failure(let error):
            completion(response: Result.Failure(error))
        }
    }
}