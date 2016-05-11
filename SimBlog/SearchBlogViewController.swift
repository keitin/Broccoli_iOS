
//
//  SearchBlogViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class SearchBlogViewController: UIViewController, UITableViewDelegate ,UITextFieldDelegate {
    @IBOutlet weak var searchTextField: SearchTextFiled!
    @IBOutlet weak var tableView: UITableView!
    let searchHistory = SearchHistory()
    let searchBlogViewModel = SearchBlogViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBlogViewModel.didLoad(tableView)
        searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem("Cancel", target: self, action: #selector(SearchBlogViewController.tapCancelButton(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table View Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }
    
    func tapCancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text == "" { return true }
        searchHistory.addText(textField.text!)
        searchHistory.saveInLocal()
        return true
    }

}
