//
//  onBoardingViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 30/10/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

var imageArr = [UIImage]()
class onBoardingViewController: UIViewController , UIScrollViewDelegate{

    var currentPage: Int = 0
    @IBOutlet weak var collectionView: UICollectionView!
    

    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var startButton: UIButton!
    fileprivate var pageSize: CGSize {
    let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
    var pageSize = layout.itemSize
    if layout.scrollDirection == .horizontal {
    pageSize.width += layout.minimumLineSpacing
    } else {
    pageSize.height += layout.minimumLineSpacing
    }
    return pageSize
    }

//    MARK:: Root Navigation
    @IBAction func startButtonClick(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//        let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
//        let appDelegate = UIApplication.shared.windows
//        appDelegate.first?.rootViewController = tabBarVC
        
        let storyboard = UIStoryboard(name: "Signin", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Signin") as! SigninViewController
        let appDelegate = UIApplication.shared.windows
        appDelegate.first?.rootViewController = vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLogin()
        
        startButton.isHidden = true
        pageControl.currentPage = 0
        
        imageArr = [#imageLiteral(resourceName: "Group 1-On Boarding"),#imageLiteral(resourceName: "Group 2-On Boarding"),#imageLiteral(resourceName: "Group 3-On Boarding")]
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: collectionView.frame.size.height)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0
        floawLayout.sideItemAlpha = 0
        floawLayout.spacingMode = .fixed(spacing: 10.0)
        collectionView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        collectionView.collectionViewLayout = floawLayout

    }    
    func checkLogin() {
        if Defaults.getUserLogin() {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
            let appDelegate = UIApplication.shared.windows
            appDelegate.first?.rootViewController = tabBarVC
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        pageControl.currentPage = currentPage
        if pageControl.currentPage == 2 {
            startButton.isHidden = false
        }else {
            
            startButton.isHidden = true
        }
    }
}
extension onBoardingViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! OnBoardingCollectionViewCell
        cell.imageView.image = imageArr[indexPath.row]
        return cell
    }

}
