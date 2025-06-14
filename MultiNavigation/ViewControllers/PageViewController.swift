//
//  PageViewController.swift
//  MultiNavigation
//
//  Created by Saurabh Gupta on 11/06/25.
//

import UIKit

class PageViewController: UIPageViewController {
  
  private lazy var pages: [UIViewController] = {
    return [
      HomeViewController(),
      SearchViewController(),
      ProfileViewController(),
    ]
  }()
  
  override init(transitionStyle style: UIPageViewController.TransitionStyle,
                navigationOrientation: UIPageViewController.NavigationOrientation,
                options: [UIPageViewController.OptionsKey : Any]? = nil) {
    super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    dataSource = self
    delegate = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let firstViewController = pages.first else { return }
    setViewControllers([firstViewController], direction: .forward, animated: true)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    for subview in view.subviews {
      subview.frame = self.view.bounds
    }
  }
  
}

// MARK: - Delegate & DataSource

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController),
          index > 0 else { return nil }
    let previousViewController = pages[index - 1]
    return previousViewController
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController),
          index < pages.count - 1 else { return nil }
    let nextViewController = pages[index + 1]
    return nextViewController
  }
  
}
