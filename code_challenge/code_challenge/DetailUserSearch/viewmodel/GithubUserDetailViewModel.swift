//
//  GithubUserDetailViewModel.swift
//  code_challenge
//
//  Created by Dilip on 4/6/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation
import UIKit
class GithubUserDetailViewModel {
    var user: User?
    var login: String?
    var email: String?
    var location: String?
    var created: String?
    var followersString: String?
    var followingString: String?
    var bioString: String?
    
    init(user: User) {
        self.user = user
        login = user.login
        email = user.email
        location = user.location
        created = user.created
        followersString = "\(user.followers)"
        followingString = "\(user.following)"
        bioString = user.bio
    }
    func getAllRepositories(userRepoUrl: String? ,completion: @escaping ([RepositoryDetail]?, Error?) -> Void) {
        guard let urlString = userRepoUrl else {
            completion(nil,NetworkCallError.invalidURL)
            return
        }
        NetworkLayer().getResponseForUrl(urlString: urlString, [RepositoryDetail].self) { (data, error) in
            if error != nil {
                completion(nil,NetworkCallError.serviceFailure)
            }
            completion(data,nil)
        }
    }
}

