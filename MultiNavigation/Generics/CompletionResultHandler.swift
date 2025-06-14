//
//  CompletionResultHandler.swift
//  MultiNavigation
//
//  Created by Saurabh Gupta on 11/06/25.
//

import UIKit

typealias AsyncResults<T> = Result<T, Error>
typealias CompletionResultHandler<T> = (Result<T, Error>) -> Void

extension Result {
  
  var isSuccess: Bool {
    switch self {
    case .success:
      return true
    case .failure:
      return false
    }
  }
  
}

enum CustomError: String, Error {
  
  case guardFailed = "GuardFailed"
  case apiFailure = "API Failure"
  
}
