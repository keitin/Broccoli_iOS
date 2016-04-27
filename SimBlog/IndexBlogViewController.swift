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
    
    func modalNewBlog(sender: UIBarButtonItem) {
        performSegueWithIdentifier("ModalNewBlog", sender: nil)
    }
    
    //MARK - TableView Delagate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 165
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
