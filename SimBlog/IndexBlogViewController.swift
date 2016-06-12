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
    @IBOutlet weak var textFieldButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        //アイテム同士のマージン
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        
        //インスタンス変数を定義していきましょう
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.collectionView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height - (self.navigationController?.navigationBar.frame.height)! - (self.tabBarController?.tabBar.frame.height)! - 20)
        self.view.addSubview(self.collectionView)
        
        indexBlogViewModel.didLoad(collectionView)
        collectionView.delegate = self
        
        layoutTextFieldButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Collection View Delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let showBlogVC = UIStoryboard.viewControllerWith("Blog", identifier: "ShowBlogViewController") as! ShowBlogViewController
            showBlogVC.blog = blogManager.blogAtPosition(indexPath.row)
            self.navigationController?.pushViewController(showBlogVC, animated: true)
        } else {
            indexBlogViewModel.loadMoreItems()
        }
        
    }
    
    //MARK - Collection View Delegate Flow Layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            let cellSize = self.view.frame.size.width/3 - 1
            return CGSizeMake(cellSize, cellSize)
        } else {
            return CGSizeMake(self.view.frame.width, 50)
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
    
    private func layoutTextFieldButton() {
        textFieldButton.frame.size.width = self.view.frame.width - 16
        textFieldButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        textFieldButton.setTitle("検索", forState: .Normal)
        textFieldButton.layer.cornerRadius = 5
        textFieldButton.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    }

}
