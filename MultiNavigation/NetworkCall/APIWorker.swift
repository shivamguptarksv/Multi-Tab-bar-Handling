//
//  APIWorker.swift
//  MultiNavigation
//
//  Created by Saurabh Gupta on 11/06/25.
//

import UIKit

protocol APIWorkerProtocol: AnyObject {
  func getAssignmentData(url: URL?) async -> AsyncResults<[CoinBaseDataModel]>
  func getAssignmentCompletion(completion: @escaping CompletionResultHandler<[CoinBaseDataModel]>)
  func downloadImage(imageUrl: String,
                     completion: @escaping CompletionResultHandler<UIImage?>)
}

class APIWorker: APIWorkerProtocol {
    
  let urlSession: URLSession
  
  init(urlSession: URLSession) {
    self.urlSession = urlSession
  }
  
  func getAssignmentData(url: URL?) async -> AsyncResults<[CoinBaseDataModel]> {
    // TODO: add logic
    return await fetchData(url)
  }
  
  func getAssignmentCompletion(completion: @escaping CompletionResultHandler<[CoinBaseDataModel]>) {
    // TODO: Add logic
  }
  
  func downloadImage(imageUrl: String,
                     completion: @escaping CompletionResultHandler<UIImage?>) {
    guard let url = URL(string: imageUrl) else { return }
    urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in
      if error == nil,
         let data {
        debugPrint("downloadImage scccess: \(data)")
      } else {
        debugPrint("downloadImage Error occured")
      }
    }.resume()
  }
  
}

// MARK: - API callls

private typealias RemoteDataHelper = APIWorker
private extension RemoteDataHelper {
  
  //  func fetchData() async -> AsyncResults<[CoinBaseDataModel]> {
  //    let urlString = "https://37656be98b8f42ae8348e4da3ee3193f.api.mockbin.io/"
  //    guard let url = URL(string: urlString) else { return await .failure(CustomError.guardFailed) }
  //    urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in
  //      if error == nil,
  //         let data,
  //         let responseData = try? JSONDecoder().decode([CoinBaseDataModel].self, from: data),
  //         let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
  //        debugPrint("ResponseData scccess: \(responseData)")
  //        debugPrint("json Response Data scccess: \(json)")
  //        return await AsyncResults.success(responseData)
  //      } else {
  //        debugPrint("Error occured")
  //        return await AsyncResults.failure(error)
  //      }
  //    }.resume()
  //  }
  
  func fetchData(_ url: URL?) async -> AsyncResults<[CoinBaseDataModel]> {
    guard let url else {  return .failure(CustomError.guardFailed) }
    do {
      let (data, _) = try await urlSession.data(from: url)
      let responseData = try JSONDecoder().decode([CoinBaseDataModel].self, from: data)
      debugPrint("ResponseData success: \(responseData)")
      return .success(responseData)
      
    } catch {
      debugPrint("Error occurred: \(error)")
      return .failure(error)
    }
  }
  
}

// MARK: - DataModels

struct CoinBaseDataModel: Decodable {
  
  let name: String
  let symbol: String
  let is_new: Bool
  let is_active: Bool
  let type: String
  
}
