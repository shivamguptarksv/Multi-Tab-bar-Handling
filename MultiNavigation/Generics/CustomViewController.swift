//
//  CustomViewController.swift
//  MultiNavigation
//
//  Created by Saurabh Gupta on 11/06/25.
//

import UIKit

open class CustomViewController<View: UIView>: UIViewController {
  
  public var customView: View {
    get {
     return view as! View
    }
    set {
      view = newValue
    }
  }
  
  override public var title: String? {
    didSet {
      if let title {
        navigationItem.title = title
      }
    }
  }
  
  override open func loadView() {
    view = buildView(frame: UIScreen.main.bounds)
  }
  
  open func buildView(frame: CGRect) -> View {
    return View(frame: frame)
  }
  
}
