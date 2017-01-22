//
//  GetFollowsRequest.swift
//  SimBlog
//
//  Created by 松下慶大 on 2017/01/13.
//  Copyright © 2017年 matsushita keita. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct GetFollowsRequest: BroccoliRequestType {
    
    typealias Response = [User]
    
    var method: Alamofire.Method {
        return .GET
    }
    
    var path: String {
        return "/api/users/\(self.user.id)/following"
    }
    
    var parameters: [String : AnyObject]? {
        return nil
    }
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func responseFromObject(response: Alamofire.Result<AnyObject, NSError>, completion: (response: Alamofire.Result<Response, NSError>) -> Void) {
        switch response {
        case .Success(let value):
            let json = JSON(value)
            var follows: [User] = []
            for userJSON in json["follows"].array! {
                follows.append(User(apiAttributes: userJSON["follow_user"]))
            }
            completion(response: Result.Success(follows))
        case .Failure(let error):
            completion(response: Result.Failure(error))
        }
    }
}