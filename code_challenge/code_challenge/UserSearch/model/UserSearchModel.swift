//
//  UserSearchModel.swift
//  code_challenge
//
//  Created by Dilip on 4/5/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation

struct UserSearchModel: Decodable {
    let items: [UserItem]
}
struct UserItem: Decodable {
  let userURL: String
  
  enum CodingKeys: String, CodingKey {
    case userURL = "url"
  }
}
struct User: Decodable {
  let login: String
  let avatarURL: String?
  let email: String?
  let bio: String?
  let repoUrl: String
  let followers: Int
  let following: Int
  let created: String
  let publicRepos: Int
let location: String?

  
  enum CodingKeys: String, CodingKey {
    case login
    case avatarURL = "avatar_url"
    case email
    case bio = "bio"
    case repoUrl = "repos_url"
    case followers
    case following
    case created = "created_at"
    case publicRepos = "public_repos"
    case location
  }
}
