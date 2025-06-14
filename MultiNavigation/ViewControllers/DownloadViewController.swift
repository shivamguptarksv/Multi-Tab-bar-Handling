//
//  DownloadViewController.swift
//  MultiNavigation
//
//  Created by upstox on 27/05/25.
//

import UIKit

class DownloadViewController: UIViewController {
  
  private let avFundation = AVFoundationSingleton()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let router: UIButton = {
    let button = UIButton()
    button.setTitle("Tap for Next screen", for: .normal)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //    view.backgroundColor = .systemPink
    router.addTarget(self, action: #selector(navigateToNextScreen), for: .touchUpInside)
    
    router.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(router)
    view.addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      imageView.heightAnchor.constraint(equalToConstant: 100),
      imageView.widthAnchor.constraint(equalToConstant: 100),
    ])
  }
  
  @objc func navigateToNextScreen() {
    //    navigationController?.pushViewController(DownloadL2ViewController(), animated: true)
    let viewController = PageViewController(transitionStyle: .scroll,
                                            navigationOrientation: .horizontal,
                                            options: nil)
    navigationController?.pushViewController(viewController, animated: false)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //    avFundation.startTime()
    //    downloadImage(imageUrl: "https://assets.uat1.upstox.com/content/assets/images/nps/PFM011.png")
    getJsonDataFromFile()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    //    avFundation.endTime()
  }
  
  func downloadImage(imageUrl: String) {
    guard let url = URL(string: imageUrl) else { return }
    URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
      if error == nil,
         let data {
        DispatchQueue.main.async {
          self.imageView.image = UIImage(data: data)
        }
        debugPrint("downloadImage scccess: \(data)")
      } else {
        self.imageView.image = UIImage(systemName: "home")
        debugPrint("downloadImage Error occured")
      }
    }.resume()
  }
  
  func getJsonDataFromFile() {
    guard let path = Bundle.main.path(forResource: "DataWithImages", ofType: "json"),
          let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
          let jsonData = try? JSONSerialization.jsonObject(with: data) else { return }
    debugPrint("Json Extracted from File : \(jsonData)")
  }
  
}
