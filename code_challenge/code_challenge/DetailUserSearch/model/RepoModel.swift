//
//  RepoModel.swift
//  code_challenge
//
//  Created by Dilip on 4/6/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation

struct RepositoryServiceModel: Decodable {
  let items: [RepositoryDetail]
}
struct RepositoryDetail: Decodable {
  let repoName: String
  let stars: Int
  let forks: Int
  let htmlURL: URL
  
  enum CodingKeys: String, CodingKey {
    case repoName = "name"
    case stars = "stargazers_count"
    case forks
    case htmlURL = "html_url"
  }
}
