//
//  IndexBlogViewModel.swift
//  SimBlog
//
//  Created by 松下慶大 on 2016/04/27.
//  Copyright © 2016年 matsushita keita. All rights reserved.
//

import UIKit

class IndexBlogViewModel: NSObject, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    let blogManager = BlogManager.sharedInstance
    var page = 1
    
    func didLoad(collectionView: UICollectionView) {
        blogManager.getBlogsInbackgroundWithBlock(user: nil, page: page) {
            collectionView.reloadData()
        }
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.registerCell("BlogImageCell")
        collectionView.backgroundColor = UIColor.whiteColor()
    }
    
    func willAppear() {
//        blogManager.getBlogsInbackgroundWithBlock(user: nil, page: page) {
//            self.collectionView.reloadData()
//        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return blogManager.numberOfBlogs
        } else {
            return 1
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BlogImageCell", forIndexPath: indexPath) as! BlogImageCell
        cell.fillWith(blogManager.blogAtPosition(indexPath.row))
        return cell
    }
    
    
    func loadMoreItems() {
        page = page + 1
        blogManager.getBlogsInbackgroundWithBlock(user: nil, page: page) { 
//            self.insertTopRow(self.collectionView)
        }
    }
    
    
    // MARK Table View Private
    private func insertTopRow(tableView: UITableView) {
        let differenceIndex = blogManager.numberOfBlogs - tableView.numberOfRowsInSection(0)
        if differenceIndex > 0 {
            for _ in 1...differenceIndex {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: blogManager.numberOfBlogs - 1, inSection: 0)], withRowAnimation: .Fade)
            }
        }
    }
    
    private func insertNewBlogToRow(tableView: UITableView) {
        let differenceIndex = blogManager.numberOfBlogs - tableView.numberOfRowsInSection(0)
        if differenceIndex > 0 {
            for _ in 1...differenceIndex {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
            }
        }
    }
    
}
