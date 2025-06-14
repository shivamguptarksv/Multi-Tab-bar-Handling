//
//  NextViewController.swift
//  MultiNavigation
//
//  Created by upstox on 20/05/25.
//

import UIKit

class NextViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 36), height: 100)
    flowLayout.minimumInteritemSpacing = 8
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.register(NextPageCollectionCell.self, forCellWithReuseIdentifier: NextPageCollectionCell.reuseIdentifier)
    collectionView.showsVerticalScrollIndicator = false
    collectionView.bounces = false
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //        view.backgroundColor = .green
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
    ])
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    //        cell.contentView.backgroundColor = .systemYellow
    //        return cell
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextPageCollectionCell.reuseIdentifier, for: indexPath) as? NextPageCollectionCell else { return UICollectionViewCell() }
    cell.configureView(title: "Title",
                       subTitle: "Sub Title",
                       titleValue: "Title Value",
                       subTitleValue: "Sub Title Value")
    return cell
  }
  
}
