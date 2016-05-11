//
//  SeachBlogViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/05/09.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class SeachBlogViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let indexBlogViewModel = IndexBlogViewModel()
    let blogManager = BlogManager.sharedInstance
    var selectedBlog: Blog!
    var blogDisplayType: BlogDisplayType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if blogDisplayType == BlogDisplayType.Following { title = "Blog" }
        indexBlogViewModel.didLoad(tableView, viewController: self)
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
