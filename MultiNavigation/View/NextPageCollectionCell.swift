//
//  NextPageCollectionCell.swift
//  MultiNavigation
//
//  Created by upstox on 20/05/25.
//

import UIKit

class NextPageCollectionCell: UICollectionViewCell {
  
  static let reuseIdentifier = "NextPageCollectionCell"
  
  private let primaryStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalCentering
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let secondaryStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalCentering
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Title"
    label.textColor = .black
    label.font = UIFont.preferredFont(forTextStyle: .body)
    return label
  }()
  
  private let subTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Sub Title"
    label.textColor = .black
    label.font = UIFont.preferredFont(forTextStyle: .body)
    return label
  }()
  
  private let titleValue: UILabel = {
    let label = UILabel()
    label.text = "Title Value"
    label.textColor = .black
    label.font = UIFont.preferredFont(forTextStyle: .body)
    return label
  }()
  
  private let subTitleValue: UILabel = {
    let label = UILabel()
    label.text = "Sub Title Value"
    label.textColor = .black
    label.font = UIFont.preferredFont(forTextStyle: .body)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupLayout()
  }
  
  private func setupLayout() {
    layer.borderWidth = 1
    layer.borderColor = UIColor.gray.cgColor
    layer.cornerRadius = 8
    layer.masksToBounds = true
    clipsToBounds = true
    
    contentView.addSubview(primaryStackView)
    contentView.addSubview(secondaryStackView)
    
    primaryStackView.addArrangedSubview(titleLabel)
    primaryStackView.addArrangedSubview(titleValue)
    
    secondaryStackView.addArrangedSubview(subTitleLabel)
    secondaryStackView.addArrangedSubview(subTitleValue)
    
    NSLayoutConstraint.activate([
      primaryStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      primaryStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      primaryStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      secondaryStackView.topAnchor.constraint(equalTo: primaryStackView.bottomAnchor, constant: 16),
      secondaryStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      secondaryStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      secondaryStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }
  
  func configureView(title: String,
                     subTitle: String,
                     titleValue: String,
                     subTitleValue: String) {
    titleLabel.text = title
    self.subTitleLabel.text = subTitle
    self.titleValue.text = titleValue
    self.subTitleValue.text = subTitleValue
  }
}
