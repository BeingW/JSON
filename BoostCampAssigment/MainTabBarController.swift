//
//  MovieTabBarController.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/7/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().barTintColor = UIColor.rgb(red: 75, green: 96, blue: 205)
        UITabBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 75, green: 96, blue: 205)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        setupViewController()
        
    }
    
    //텝바 셋업
    func setupViewController() {
        
        let layout = UICollectionViewFlowLayout()
        let movieCollectionViewController = MovieCollectionViewController(collectionViewLayout: layout)
        
        viewControllers = [
            generateNavigationController(for: MovieTableViewController() , title: "Table", image: UIImage(named: "ListViewIcon@2x.png")!),
            generateNavigationController(for: movieCollectionViewController, title: "Collection", image: UIImage(named: "CollectionViewIcon@2x.png")!)
        ]
        
        
        
    }
    
    //텝바 네비게이션 폼
    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.backgroundColor = UIColor(displayP3Red: 71, green: 90, blue: 191, alpha: 0)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
    
}

