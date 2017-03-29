//
//  RequestType.swift
//  SimBlog
//
//  Created by 松下慶大 on 2017/01/13.
//  Copyright © 2017年 matsushita keita. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

protocol RequestType {
    
    associatedtype Response
    
    var baseURL: String { get }
    var path: String { get }
    var method: Alamofire.Method { get }
    var parameters: [String : AnyObject]? { get }
    
    func sendRequest(completion: (response: Alamofire.Result<Response, NSError>) -> Void)
    func responseFromObject(response: Alamofire.Result<AnyObject, NSError>, completion: (response: Alamofire.Result<Response, NSError>) -> Void)
}

extension RequestType {
    func sendRequest(completion: (response: Alamofire.Result<Response, NSError>) -> Void) {
        Alamofire.request(method, baseURL + path, parameters: parameters)
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    StatusBarNotification.hideMessage()
                case .Failure:
                    StatusBarNotification.showErrorMessage()
                }
                
                self.responseFromObject(response.result, completion: { (response) in
                    completion(response: response)
                })
        }
    }
}
