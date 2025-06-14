//
//  SheetPresentationController.swift
//  MultiNavigation
//
//  Created by Saurabh Gupta on 15/06/25.
//

import UIKit

class SheetPresentationController: UIPresentationController {
  
  private let bottomsheetHeightPercentage: CGFloat
  private let ondismiss: (() -> Void)?
  
  init(presentedViewController: UIViewController,
       presenting: UIViewController?,
       bottomsheetHeightPercentage: CGFloat = 60.0,
       ondismiss: (() -> Void)? = nil) {
    self.bottomsheetHeightPercentage = bottomsheetHeightPercentage
    self.ondismiss = ondismiss
    super.init(presentedViewController: presentedViewController, presenting: presenting)
  }
  
  private lazy var dimmingView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    view.alpha = 0
    view.frame = containerView?.bounds ?? .zero
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissBottomsheet))
    view.addGestureRecognizer(tapGesture)
    return view
  }()
  
  private let grabberHeight: CGFloat = 24
  private let grabberView = UIView()
  
  private let dragHandlePill: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .gray
    view.layer.cornerRadius = 2
    view.clipsToBounds = true
    return view
  }()
  
  override func presentationTransitionWillBegin() {
    guard let containerView = containerView else { return }
    
    containerView.insertSubview(dimmingView, at: 0)
    dimmingView.alpha = 0
    presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 1
    })
    
    setupGrabberView()
  }
  
  override func dismissalTransitionWillBegin() {
    presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0
    })
  }
  
}

// MARK: - Dismiss
private typealias DismissHelper = SheetPresentationController
extension DismissHelper {
  
  @objc func dismissBottomsheet() {
    ondismiss?()
    presentedViewController.dismiss(animated: true)
  }
  
  @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
    guard let view = presentedView else { return }
    let translation = gesture.translation(in: containerView)
    
    switch gesture.state {
    case .changed:
      if translation.y > 0 {
        view.frame.origin.y = (containerView?.bounds.height ?? 0) - view.frame.height + translation.y
      }
    case .ended:
      let velocity = gesture.velocity(in: containerView).y
      if velocity > 1000 || translation.y > 100 {
        dismissBottomsheet()
      } else {
        UIView.animate(withDuration: 0.3) {
          self.containerViewWillLayoutSubviews()
        }
      }
    default:
      break
    }
  }
  
  private func setupGrabberView() {
    grabberView.addSubview(dragHandlePill)
    grabberView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    grabberView.clipsToBounds = true
    grabberView.layer.cornerRadius = 8
    grabberView.backgroundColor = .white // UIColor.black.withAlphaComponent(0.3)
    grabberView.isUserInteractionEnabled = true
    presentedViewController.view.addSubview(grabberView)
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    grabberView.addGestureRecognizer(panGesture)
  }
  
  override func containerViewWillLayoutSubviews() {
    super.containerViewWillLayoutSubviews()
    guard let containerView = containerView else { return }
    
    let height = containerView.bounds.height * bottomsheetHeightPercentage / 100
    let y = containerView.bounds.height - height
    presentedView?.frame = CGRect(x: 0, y: y, width: containerView.bounds.width, height: height)
    dimmingView.frame = containerView.bounds
    grabberView.frame = CGRect(x: 0, y: -24, width: containerView.bounds.width, height: grabberHeight)
    
    NSLayoutConstraint.activate([
      dragHandlePill.centerXAnchor.constraint(equalTo: grabberView.centerXAnchor),
      dragHandlePill.centerYAnchor.constraint(equalTo: grabberView.centerYAnchor),
      
      dragHandlePill.widthAnchor.constraint(equalToConstant: 32),
      dragHandlePill.heightAnchor.constraint(equalToConstant: 4)
    ])
  }
  
}
