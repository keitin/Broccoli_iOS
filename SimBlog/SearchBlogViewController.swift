
//
//  SearchBlogViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class SearchBlogViewController: UIViewController, UITableViewDelegate ,UITextFieldDelegate, BlogCellDelegate {
    @IBOutlet weak var blogsTableView: UITableView!
    @IBOutlet weak var searchTextField: SearchTextFiled!
    @IBOutlet weak var historyTableView: UITableView!
    let searchHistory = SearchHistory()
    let searchBlogViewModel = SearchBlogViewModel()
    let searchResultsBlogViewModel = SearchResultsBlogViewModel()
    let blogManager = BlogManager.sharedInstance
    var didSearched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBlogViewModel.didLoad(historyTableView)
        searchResultsBlogViewModel.didLoad(blogsTableView, viewController: self)
        searchTextField.delegate = self
        historyTableView.delegate = self
        blogsTableView.delegate = self
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
        if didSearched {
            if indexPath.section == 0 {
                return 165
            } else {
                return 50
            }
        } else {
            return 56
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let showBlogVC = UIStoryboard.viewControllerWith("Blog", identifier: "ShowBlogViewController") as! ShowBlogViewController
            showBlogVC.blog = blogManager.searchBlogs[indexPath.row]
            self.navigationController?.pushViewController(showBlogVC, animated: true)
        } else if indexPath.section == 1 {
            searchResultsBlogViewModel.loadMoreItems()
        }
    }
    
    func tapCancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text == "" { return true }
        searchHistory.addText(textField.text!)
        searchHistory.saveInLocal()
        
        historyTableView.hidden = true
        didSearched = true
        searchResultsBlogViewModel.searchBlogs(textField.text!) {
            self.blogsTableView.reloadData()
        }
        
        return true
    }
    
    func didTapProfileImageView(blog: Blog) {
    
    }

}
