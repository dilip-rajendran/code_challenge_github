//
//  UserCellViewModel.swift
//  code_challenge
//
//  Created by Dilip on 4/6/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation
import UIKit
class UserCellViewModel {
    let userUrl: String
    var username: String? = nil
    var repoCount: Int? = nil
    var user: User? = nil
    init(userUrl: String) {
        self.userUrl = userUrl
        }
func getUserDetails(completion: @escaping(User?, Error?) -> Void) {
        NetworkLayer().getResponseForUrl(urlString: userUrl, User.self) { (data, error) in
            if error != nil {
                completion(nil,NetworkCallError.serviceFailure)
            }
            if let response = data {
                self.user = response
                completion(response,nil)
            }
        }
    }
}
