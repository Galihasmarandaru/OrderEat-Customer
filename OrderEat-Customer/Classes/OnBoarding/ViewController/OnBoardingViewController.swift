//
//  onBoardingViewController.swift
//  OrderEat-Customer
//
//  Created by Malvin Santoso on 30/10/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class onBoardingViewController: UIViewController , UIScrollViewDelegate{


    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var pageControl: UIPageControl!

    @IBOutlet weak var startButton: UIButton!
    
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
        setupScroll()
        scrollView.delegate = self
    }
    
    func checkLogin() {
        if Defaults.getUserLogin() {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let tabBarVC = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
            let appDelegate = UIApplication.shared.windows
            appDelegate.first?.rootViewController = tabBarVC
        }
    }
    
    func setupScroll()
       {
            var imageArr = [UIImage]()
            imageArr = [#imageLiteral(resourceName: "Group 1-On Boarding"),#imageLiteral(resourceName: "Group 2-On Boarding"),#imageLiteral(resourceName: "Group 3-On Boarding")]
            let screenWidth = self.view.frame.size.width
            scrollView.contentSize = CGSize(width: screenWidth * CGFloat(imageArr.count), height: scrollView.frame.size.height)
           scrollView.layer.borderColor = UIColor.black.cgColor
           scrollView.layer.borderWidth = 1
            scrollView.isPagingEnabled = true
           
        for i in 0..<imageArr.count
           {
            let imageView = UIImageView()
            imageView.image = imageArr[i]
            let xPosition = self.view.frame.width * CGFloat(i) + 100
            imageView.frame = CGRect(x: xPosition, y: 120, width: self.view.frame.width/2, height: self.view.frame.height/2)
            imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
                        
        }
        
       }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(page)
        if pageControl.currentPage == 2 {
            startButton.isHidden = false
        }else {
            
            startButton.isHidden = true
        }
    }
    

}
