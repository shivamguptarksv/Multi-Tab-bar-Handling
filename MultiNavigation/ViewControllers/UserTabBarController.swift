//
//  UserTabBarController.swift
//  MultiNavigation
//
//  Created by upstox on 20/05/25.
//

import UIKit

class UserTabBarController: UITabBarController, UITabBarControllerDelegate {
  
  let userDefaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    self.delegate = self
  }
  
  func configureView() {
    let vc1 = HomeViewController()
    let vc2 = SearchViewController()
    let vc3 = ProfileViewController()
    let vc4 = DownloadViewController()
    let vc5 = DownloadL2CompositionViewController()
    
    vc1.tabBarItem.title = "Home"
    vc2.tabBarItem.title = "Search"
    vc3.tabBarItem.title = "Profile"
    vc4.tabBarItem.title = "Download"
    vc5.tabBarItem.title = "Composition Layout"
    
    vc1.tabBarItem.image = UIImage(systemName: "house")
    vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    vc3.tabBarItem.image = UIImage(systemName: "person")
    vc4.tabBarItem.image = UIImage(systemName: "arrow.down")
    vc5.tabBarItem.image = UIImage(systemName: "gear")
    
    let nav1 = UINavigationController(rootViewController: vc1)
    let nav2 = UINavigationController(rootViewController: vc2)
    let nav3 = UINavigationController(rootViewController: vc3)
    let nav4 = UINavigationController(rootViewController: vc4)
    let nav5 = UINavigationController(rootViewController: vc5)
    
    tabBar.tintColor = .systemBlue
    tabBar.backgroundColor = .systemGray6
    setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: false)
    //    selectedViewController = nav2
    selectedIndex = userDefaults.integer(forKey: "lastSelectedTab")
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    debugPrint("Selected Index: \(tabBarController.selectedIndex)")
    userDefaults.set(tabBarController.selectedIndex, forKey: "lastSelectedTab")
  }
  
}
