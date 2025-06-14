//
//  ProfileViewController.swift
//  MultiNavigation
//
//  Created by upstox on 20/05/25.
//

import UIKit

class ProfileViewController: UIViewController {
  
  lazy var button: UIButton = {
    let button = UIButton()
    button.setTitle("Next Page", for: .normal)
    button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
    button.setTitleColor(.systemBlue, for: .normal)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .cyan
    configureView()
  }
  
  func configureView() {
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  @objc func handleNextPage() { // PageViewController
    navigationController?.pushViewController(NextViewController(), animated: true)
  }
  
}
