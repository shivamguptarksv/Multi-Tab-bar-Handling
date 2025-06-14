//
//  ViewController.swift
//  MultiNavigation
//
//  Created by upstox on 20/05/25.
//

import UIKit

class HomeViewController: UIViewController {
  
  private let apiWorker = APIWorker(urlSession: URLSession.shared)
  
  lazy var button: UIButton = {
    let button = UIButton()
    button.setTitle("Next Page", for: .normal)
    button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
    button.setTitleColor(.systemBlue, for: .normal)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //    fetchData()
    Task { [weak self] in
      guard let self else { return }
      let urlString = "https://37656be98b8f42ae8348e4da3ee3193f.api.mockbin.io/"
      let result = await apiWorker.getAssignmentData(url: URL(string: urlString))
      switch result {
      case .success(let data):
        debugPrint("success data: \(data)")
      case .failure(let error):
        debugPrint("failure error: \(error)")
      }
    }
  }
  
  func configureView() {
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  @objc func handleNextPage() {
    //        navigationController?.pushViewController(NextViewController(), animated: true)
    let viewController = NextViewController()
    viewController.modalPresentationStyle = .custom
    viewController.transitioningDelegate = self
    viewController.modalPresentationCapturesStatusBarAppearance = true
    navigationController?.present(viewController, animated: true)
  }
  
}

// MARK: - API callls

private typealias RemoteDataHelper = HomeViewController
private extension RemoteDataHelper {
  
  func fetchData() {
    let urlString = "https://37656be98b8f42ae8348e4da3ee3193f.api.mockbin.io/"
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
      if error == nil,
         let data,
         let responseData = try? JSONDecoder().decode([CoinBaseDataModel].self, from: data),
         let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
        debugPrint("ResponseData scccess: \(responseData)")
        debugPrint("json Response Data scccess: \(json)")
      } else {
        if let error {
          debugPrint("Error occured: \(error)")
        }
      }
    }.resume()
  }
  
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
  
  func presentationController(forPresented presented: UIViewController,
                              presenting: UIViewController?,
                              source: UIViewController) -> UIPresentationController? {
    SheetPresentationController(presentedViewController: presented, presenting: presenting)
  }
}
