//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 12/11/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    private let vc1: UINavigationController = {
        let vc = UINavigationController(rootViewController: HomeViewController())
        vc.title = "Home"
        vc.tabBarItem.image = UIImage(systemName: "house")
        return vc
    }()
    
    private let vc2: UINavigationController = {
        let vc = UINavigationController(rootViewController: UpcomingViewController())
        vc.title = "Upcoming"
        vc.tabBarItem.image = UIImage(systemName: "play.circle")
        return vc
    }()
    
    private let vc3: UINavigationController = {
        let vc = UINavigationController(rootViewController: SearchViewController())
        vc.title = "Search"
        vc.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        return vc
    }()
    
    private let vc4: UINavigationController = {
        let vc = UINavigationController(rootViewController: DownloadViewController())
        vc.title = "Downloads"
        vc.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .label
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }

}

