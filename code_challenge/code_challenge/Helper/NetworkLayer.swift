//
//  NetworkDataRetriever.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import UIKit
enum NetworkCallError: Error {
    case jsonDecodeFailure
    case serviceFailure
    case invalidURL
    case unauthorized
    case failedImageData
}
struct NetworkLayer {
  let oAuthHeaders = ["Authorization": "token 48fc9315d12a8010b82db7ed763ae82cfd7c35c5"]

  func getResponseForUrl<T: Decodable>(urlString: String, _ decodableType: T.Type, completion: @escaping (T?, Error?) -> Void) {
    
    URLSession.shared.makeRequestForUrl(urlString: urlString, headers: oAuthHeaders) { (data, error) in
        guard let data = data else {
          completion(nil, NetworkCallError.serviceFailure)
          return
        }
        do {
          let decodedObject = try JSONDecoder().decode(T.self, from: data)
          completion(decodedObject, nil)
        } catch {
            completion(nil, NetworkCallError.jsonDecodeFailure)
        }
    }
  }
  
  func getImageDataForURL(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
    
    URLSession.shared.makeRequestForUrl(urlString: urlString, headers: oAuthHeaders) { (data, error) in
        guard error == nil else {
            completion(nil, NetworkCallError.serviceFailure)
          return
        }
        
        guard let data = data else {
          completion(nil, NetworkCallError.failedImageData)
          return
        }
          completion(data, NetworkCallError.failedImageData)
          return
    }
  }
}

extension URLSession {
  func makeRequestForUrl(urlString: String, headers: [String: String], completion: @escaping (Data?, Error?) -> Void) {
    guard let url = URL(string: urlString) else {
      completion(nil, NetworkCallError.invalidURL)
      return
    }
    var request = URLRequest(url: url)
    if !headers.isEmpty {
      request.allHTTPHeaderFields = headers
    }
    self.dataTask(with: request) { (data, response, error) in
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == ConstantNumber.UnauthorizedErrorCode.rawValue else {
        completion(data, error)
        return
      }
      completion(nil, NetworkCallError.unauthorized)
    }.resume()
  }
}
