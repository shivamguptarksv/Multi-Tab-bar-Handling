//
//  SearchViewController.swift
//  MultiNavigation
//
//  Created by upstox on 20/05/25.
//

import UIKit
import WebKit

class SearchViewController: CustomViewController<UIView> {
  
  private var webView: WKWebView!
  
  private let refresh = UIRefreshControl()
  
  //  private let navigationBar: UINavigationBar = {
  //    let navigationBar = UINavigationBar()
  //    let items = UINavigationItem(title: "Coin")
  //    //    navigationBar.barTintColor = .lightGray
  //    navigationBar.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: ., target: <#T##Any?#>, action: <#T##Selector?#>)
  //    navigationBar.items = [items]
  //    return navigationBar
  //  }()
  
  private let navigationBar: UINavigationBar = {
    let navigationBar = UINavigationBar()
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    navigationBar.barTintColor = .systemGray6
    navigationBar.backgroundColor = .systemGray6
    
    let navItem = UINavigationItem(title: "Coin")
    
    let backButton = UIBarButtonItem(barButtonSystemItem: .rewind,
                                     target: self,
                                     action: #selector(backButtonTap)) // ic_back2
    navItem.leftBarButtonItem = backButton
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                    target: self,
                                    action: #selector(addButtonTap))
    navItem.rightBarButtonItem = addButton
    
    navigationBar.items = [navItem]
    return navigationBar
  }()
  
  //  button.setImage(UIImage(named: "ic_back2")?.withRenderingMode(.alwaysTemplate), for: .normal)
  //  button.setImage(UIImage(named: "ic_close")?.withRenderingMode(.alwaysTemplate), for: .normal)
  
  // MARK: - Search Bar Setup
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.placeholder = "Start typing to search"
    return searchBar
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
  }
  
  @objc func refreshData() {
    // Handle refresh
    debugPrint("refreshData")
  }
  
  func configureView() {
    navigationController?.isNavigationBarHidden = true
    searchBar.delegate = self
    view.addSubview(searchBar)
    view.addSubview(navigationBar)
    intializeWebView()
    
    NSLayoutConstraint.activate([
      navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      navigationBar.heightAnchor.constraint(equalToConstant: 48.0),
      
      searchBar.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      
      webView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  @objc func backButtonTap() {
    // TODO: Add logic
    DispatchQueue.main.async {
      self.webView.removeFromSuperview()
    }
  }
  
  @objc func addButtonTap() {
    // TODO: Add logic
    view.insertSubview(webView, belowSubview: searchBar)
    openWebView(with: "https://maxim-kryloff.medium.com/swift-concurrency-810fdbe0b248")
  }
  
}

extension SearchViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    debugPrint("textDidChange: \(searchText)")
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""
    searchBar.resignFirstResponder()
    searchBar.setShowsCancelButton(false, animated: true)
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    debugPrint("3: UISearchBarDelegate searchBarTextDidBeginEditing")
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBarCancelButtonClicked(searchBar)
  }
  
}

// MARK: - JsonDataHelper

private typealias WebViewHelper = SearchViewController
extension WebViewHelper {
  
  //   openWebView(with: "https://maxim-kryloff.medium.com/swift-concurrency-810fdbe0b248")
  
  func intializeWebView() {
    webView = WKWebView(frame: view.bounds)
    webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.insertSubview(webView, belowSubview: searchBar)
    //    openWebView(with: "https://maxim-kryloff.medium.com/swift-concurrency-810fdbe0b248")
  }
  
  func openWebView(with urlString: String) {
    guard let url = URL(string: urlString) else { return }
    DispatchQueue.main.async {
      self.webView.load(URLRequest(url: url))
    }
  }
  
}

extension SearchViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    // TODO: Add logic
  }
  
  //  func webView(_ webView: WKWebView,
  //               decidePolicyFor navigationAction: WKNavigationAction,
  //               decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {
  //    switch navigationAction.navigationType {
  //    case .backForward:
  //      print("Back or forward navigation")
  //    case .linkActivated:
  //      print("User tapped a link")
  //    default:
  //      break
  //    }
  //  }
  //
}
