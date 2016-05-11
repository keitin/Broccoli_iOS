//
//  SearchHistory.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class SearchHistory: NSObject {
    
    var texts: [String] = []
    var numberOfTexts: Int {
        return texts.count
    }
    
    override init() {
        super.init()
        getInlocal()
    }
    
    func addText(text: String) {
        texts.append(text)
    }
    
    func textAtPosition(index: Int) -> String {
        return texts[index]
    }
    
    func getInlocal() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let texts = defaults.objectForKey("history_texts") as? [String] {
            self.texts = texts
            print(self.texts)
        }
    }
    
    func saveInLocal() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.texts, forKey: "history_texts")
        defaults.synchronize()
    }
    
    func deleteinLocal() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("history_texts")
        defaults.synchronize()
        self.texts = []
    }
}
