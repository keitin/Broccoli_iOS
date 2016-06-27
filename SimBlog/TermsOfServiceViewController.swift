//
//  TermsOfServiceViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/06/22.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class TermsOfServiceViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "利用規約"
        self.textView.text = Message.term
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Delete-50"), style: .Done, target: self, action: #selector(TermsOfServiceViewController.closeVC(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeVC(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
