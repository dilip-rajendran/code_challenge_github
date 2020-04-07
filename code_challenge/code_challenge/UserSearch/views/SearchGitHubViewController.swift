//
//  ViewController.swift
//  code_challenge
//
//  Created by Dilip on 4/5/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import UIKit

class SearchGitHubViewController: UITableViewController {
    private var searchTimer: Timer?
    var dataSource: [UserItem]? = nil
    var headerSearchString: String = ConstantIdentifiers.UserHeaderSearchString.rawValue
    let headerSearchView = ViewHelper.headerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        headerSearchView.titleLabel.text = headerSearchString
        headerSearchView.searchBar.delegate = self
        headerSearchView.searchBar.placeholder = ConstantIdentifiers.UserSearchBarPlaceHolder.rawValue
        
    }
    fileprivate func setupTableView() {
        let productCell = UINib(nibName: ConstantIdentifiers.UserCellNibName.rawValue, bundle: nil)
        tableView.register(productCell, forCellReuseIdentifier: ConstantIdentifiers.UserCellIdentifier.rawValue)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
}

extension SearchGitHubViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerSearchView.header
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ConstantIdentifiers.UserCellIdentifier.rawValue, for: indexPath) as? UserTableViewCell, let instanceModel = dataSource?[indexPath.row] {
            cell.bindViewModel(viewModel: UserCellViewModel(userUrl: instanceModel.userURL))
            return cell
        }
        return UITableViewCell()
    }

}
extension SearchGitHubViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userCell = tableView.cellForRow(at: indexPath) as? UserTableViewCell, let user = userCell.user else { return }

        let detailScreen = GithubUserDetailViewController(user: user)
        navigationController?.pushViewController(detailScreen, animated: true)
    }
}

extension SearchGitHubViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(ConstantNumber.TimerInterval.rawValue), repeats: false, block: { [weak self] _ in
            NetworkLayer().getResponseForUrl(urlString: ConstantIdentifiers.BaseUserSearchURL.rawValue + searchText, UserSearchModel.self) { (data, error) in
              if error != nil {
                  
              } else {
                self?.dataSource = data?.items
                  DispatchQueue.main.async {
                    self?.headerSearchView.titleLabel.text = (self?.headerSearchString ?? "") + String(self?.dataSource?.count ?? 0)
                    self?.tableView.reloadData()
                    self?.tableView.separatorStyle = .singleLine

                  }
              }
          }
        })

    }
}
