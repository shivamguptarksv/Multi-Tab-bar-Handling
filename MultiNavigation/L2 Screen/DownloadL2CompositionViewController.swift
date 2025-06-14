//
//  DownloadL2CompositionViewController.swift
//  MultiNavigation
//
//  Created by upstox on 27/05/25.
//

import UIKit

class DownloadL2CompositionViewController: UIViewController {
  
  private lazy var compoaitionCollectionView: UICollectionView = {
    let layout = getLayout()
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    collectionView.bounces = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DummyCell")
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //        view.backgroundColor = .green
    setupLayout()
  }
  
  private func setupLayout() {
    compoaitionCollectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(compoaitionCollectionView)
    NSLayoutConstraint.activate([
      compoaitionCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      compoaitionCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      compoaitionCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      compoaitionCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
}

// MARK: - LayoutHelper

private typealias LayoutHelper = DownloadL2CompositionViewController
private extension LayoutHelper {
  
  func getLayout() -> UICollectionViewLayout {
    return UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
      if sectionIndex == 0 { // Title
        return self.getTitleLayoutSection()
      } else if sectionIndex == 1 { // Status Collection
        return self.getStatusCollectionLayoutSection()
      } else { // Feed View
        return self.getFeedLayoutSection()
      }
    }
    
  }
  
  func getTitleLayoutSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .absolute(40.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
    let sectionLayout = NSCollectionLayoutSection(group: group)
    return sectionLayout
  }
  
  func getStatusCollectionLayoutSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(64),
                                          heightDimension: .absolute(64))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(80),
                                           heightDimension: .absolute(80))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
    let sectionLayout = NSCollectionLayoutSection(group: group)
    sectionLayout.orthogonalScrollingBehavior = .continuous
    return sectionLayout
  }
  
  func getFeedLayoutSection() -> NSCollectionLayoutSection {
    let postHeader = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)))
    let postImage = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)))
    let postAction = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)))
    let postCaption = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)))
    let postComment = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)))
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(500.0))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                 subitems: [postHeader, postImage, postAction, postCaption, postComment])
    let sectionLayout = NSCollectionLayoutSection(group: group)
    return sectionLayout
  }
  
}

extension DownloadL2CompositionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    3
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 { // Title
      return 1
    } else if section == 1 { // Status Collection
      return 15
    } else { // Feed View
      return 5
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DummyCell", for: indexPath)
    if indexPath.section == 0 { // Title
      cell.backgroundColor = .yellow
      return cell
    } else if indexPath.section == 1 { // Status Collection
      cell.backgroundColor = .systemPink
      return cell
    } else { // Feed View
      if indexPath.row == 0 {
        cell.backgroundColor = .gray
      } else if indexPath.row == 1 {
        cell.backgroundColor = .green
      } else if indexPath.row == 2 {
        cell.backgroundColor = .orange
      } else if indexPath.row == 3 {
        cell.backgroundColor = .blue
      } else if indexPath.row == 4 {
        cell.backgroundColor = .brown
      } else {
        cell.backgroundColor = .cyan
      }
      return cell
    }
  }
  
}
