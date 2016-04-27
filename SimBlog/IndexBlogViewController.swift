//
//  BlogListViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class IndexBlogViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let indexBlogViewModel = IndexBlogViewModel()
    let blogManager = BlogManager.sharedInstance
    var selectedBlog: Blog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Blog"
        indexBlogViewModel.didLoad(tableView)
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        indexBlogViewModel.willAppear()
        navigationItem.rightBarButtonItem("New", target: self, action: #selector(IndexBlogViewController.modalNewBlog(_:)))        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK - TableView Delagate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 165
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedBlog = blogManager.blogAtPosition(indexPath.row)
        performSegueWithIdentifier("showBlog", sender: nil)
    }
    
    func modalNewBlog(sender: UIBarButtonItem) {
        performSegueWithIdentifier("ModalNewBlog", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBlog" {
            let showBlogVC = segue.destinationViewController as! ShowBlogViewController
            showBlogVC.blog = selectedBlog
        }
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
