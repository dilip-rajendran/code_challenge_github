//
//  Constants.swift
//  code-challenge
//
//  Created by Dilip on 3/25/20.
//  Copyright © 2020 Dilip. All rights reserved.
//
import Foundation
import UIKit
public enum ConstantNumber: Int {
    case DefaultRows = 0
    case UnauthorizedErrorCode = 403
    case TimerInterval = 2
}

public enum ConstantIdentifiers: String {
    //Network constants
    case BaseUserSearchURL = "https://api.github.com/search/users?q="
    case BaseRepoSearchURL = "https://api.github.com/search/repositories?q="
    // Placeholder constants
    case UserHeaderSearchString = "   Search GitHub users:"
    case RepoHeaderSearchString = "   Search repos: "
    case UserSearchBarPlaceHolder = "Start searching a user"
    case RepoSearchBarPlaceHolder = "Start searching a repo"
    case RepoCountPlaceHolder = "Repo Count: "
    case ForkPlaceHolder = "Forks: "
    case StarsPlaceHolder = "Stars: "
    case LoginPlaceHolder = "Name: "
    case EmailPlaceHolder = "Email: "
    case createdPlaceHolder = "Created: "
    case FollowersPlcaeHolder = "Followers: "
    case FollowingPlaceHolder = "Following: "
    case LocationPlaceHolder = "Location: "
    case BioPlaceHolder = "Bio: "
    // Cell identifier constants
    case UserCellNibName = "UserTableViewCell"
    case UserCellIdentifier = "UserTableViewCellID"
}

enum ViewHelper {
    
    static func headerView() -> (header: UIView,titleLabel: UILabel,searchBar: UISearchBar) {
        let stackView = UIStackView()
        stackView.axis = .vertical
        let label = UILabel()
        label.text = ""
        stackView.addArrangedSubview(label)
        label.backgroundColor = .white
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        stackView.addArrangedSubview(searchBar)
        searchBar.backgroundColor = .white
        return (stackView,label,searchBar)
    }
}
