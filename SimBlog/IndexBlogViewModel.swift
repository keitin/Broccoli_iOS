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
        collectionView.registerCell("MoreItemsCollectionCell")
        collectionView.backgroundColor = UIColor.whiteColor()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return blogManager.numberOfBlogs
        } else {
            return 1
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BlogImageCell", forIndexPath: indexPath) as! BlogImageCell
            cell.fillWith(blogManager.blogAtPosition(indexPath.row))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoreItemsCollectionCell", forIndexPath: indexPath) as! MoreItemsCollectionCell
            return cell
        }
        
    }
    
    
    func loadMoreItems() {
        page = page + 1
        blogManager.getBlogsInbackgroundWithBlock(user: nil, page: page) {
            self.collectionView.reloadData()
        }
    }
}
