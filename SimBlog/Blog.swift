//
//  Blog.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Blog: NSObject {
    var materials: [AnyObject] = []
    var title: String! = ""
    var sentence: String! = ""
    var topImage: UIImage?
    var id: Int!
    var numberOfMaterials: Int {
        return materials.count
    }
    
    override init() {
        super.init()
        addTextAtPosition("", index: 0)
    }
    
    func addTextAtPosition(text: String, index: Int) {
        materials.insert(BlogText(text: text, order: numberOfMaterials), atIndex: index)
    }
    
    func addImageAtPostion(image: UIImage, index: Int) {
        materials.insert(BlogImage(image: image, order: numberOfMaterials), atIndex: index)
    }
    
    func materialAtPosition(index: Int) -> AnyObject {
        return materials[index]
    }
    
    //API
    func saveInbackground() {
        
        let blogTexts = divideToBlogText()
        let blogImages = divideToBlogImage()
        
        let params: [String: AnyObject] = [
            "title": self.title,
            "sentence": self.sentence,
        ]
        
        Alamofire.request(.POST, "http://localhost:3000/api/blogs/", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                self.id = json["blog"]["id"].int
                
                for blogText in blogTexts { self.saveTextInBackground(blogText) }
                for blogImage in blogImages { self.saveImageInBackground(blogImage) }
        }
    }
    
    private func saveTextInBackground(blogText: BlogText) {
        let params: [String: AnyObject] = [
            "sentence"   : blogText.text,
            "blog_id": self.id,
            "order"  : blogText.order
        ]
        Alamofire.request(.POST, "http://localhost:3000/api/texts/", parameters: params)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                print(object)
        }
    }
    
    private func saveImageInBackground(blogImage: BlogImage) {
        let params: [String: AnyObject] = [
            "blog_id": self.id,
            "order"  : blogImage.order
        ]
        let pass = "http://localhost:3000/api/images/"
        let httpMethod = Alamofire.Method.POST.rawValue

        let urlRequest = NSData.urlRequestWithComponents(httpMethod, urlString: pass, parameters: params, image: blogImage.image)
        Alamofire.upload(urlRequest.0, data: urlRequest.1)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                print(object)
        }
    }
    
    private func divideToBlogText() -> [BlogText]{
        var blogTexts: [BlogText] = []
        for material in self.materials {
            if let blogText = material as? BlogText {
                blogTexts.append(blogText)
            }
        }
        return blogTexts
    }
    
    private func divideToBlogImage() -> [BlogImage]{
        var blogImages: [BlogImage] = []
        for material in self.materials {
            if let blogText = material as? BlogImage {
                blogImages.append(blogText)
            }
        }
        return blogImages
    }
    
    
}
