//
//  BlogListViewController.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class IndexBlogViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, BlogCellDelegate {
    var collectionView: UICollectionView!
    let indexBlogViewModel = IndexBlogViewModel()
    let blogManager = BlogManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        //アイテム同士のマージン
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        
        //インスタンス変数を定義していきましょう
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.view.addSubview(self.collectionView)
        
        indexBlogViewModel.didLoad(collectionView)
        collectionView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Collection View Delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let showBlogVC = UIStoryboard.viewControllerWith("Blog", identifier: "ShowBlogViewController") as! ShowBlogViewController
        showBlogVC.blog = blogManager.blogAtPosition(indexPath.row)
        self.navigationController?.pushViewController(showBlogVC, animated: true)
    }
    
    //MARK - Collection View Delegate Flow Layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSize = self.view.frame.size.width/3 - 1
        return CGSizeMake(cellSize, cellSize)
    }

    
    //MARK - TableView Delagate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 191
        } else {
            return 50
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let showBlogVC = UIStoryboard.viewControllerWith("Blog", identifier: "ShowBlogViewController") as! ShowBlogViewController
            showBlogVC.blog = blogManager.blogAtPosition(indexPath.row)
            self.navigationController?.pushViewController(showBlogVC, animated: true)
        } else if indexPath.section == 1 {
            indexBlogViewModel.loadMoreItems()
        }
    }
    
    func didTapProfileImageView(blog: Blog) {
        let showUserVC = UIStoryboard.viewControllerWith("User", identifier: "ShowUserViewController") as! ShowUserViewController
        showUserVC.selectedUser = blog.user
        navigationController?.pushViewController(showUserVC, animated: true)
    }

    @IBAction func tapSearchButton(sender: UIButton) {
        let searchBlogNC = UIStoryboard.viewControllerWith("Blog", identifier: "SearchBlogNavigationController")
        presentViewController(searchBlogNC, animated: false, completion: nil)
    }

}
