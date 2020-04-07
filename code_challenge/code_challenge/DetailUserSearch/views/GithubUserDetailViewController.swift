//
//  GithubUserDetailViewController.swift
//  code_challenge
//
//  Created by Dilip on 4/6/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class GithubUserDetailViewController: UIViewController {
    private var searchTimer: Timer?

    @IBOutlet weak var userAvatarImage: UIImageView!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var createdLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var repoTableView: UITableView!
    var user: User?
    var dataSource: [RepositoryDetail]? = nil
    var headerSearchString: String = ConstantIdentifiers.RepoHeaderSearchString.rawValue
    let headerSearchView = ViewHelper.headerView()
    var viewModel: GithubUserDetailViewModel?

    convenience init(user: User) {
        self.init()
        self.user = user
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userDetails = user {
            viewModel = GithubUserDetailViewModel(user: userDetails)
        }
        setupTableView()
        bindUserView()
        headerSearchView.titleLabel.text = headerSearchString
        headerSearchView.searchBar.placeholder = ConstantIdentifiers.RepoSearchBarPlaceHolder.rawValue

        headerSearchView.searchBar.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userAvatarImage.layer.cornerRadius = 75

    }
    fileprivate func getAllRepoDetails() {
        viewModel?.getAllRepositories(userRepoUrl: user?.repoUrl, completion: {[weak self] (data, error) in
            if error != nil {
                return
            }
            self?.dataSource = data
            DispatchQueue.main.async {
                self?.repoTableView.reloadData()
                self?.headerSearchView.titleLabel.text = (self?.headerSearchString ?? "") + String(self?.dataSource?.count ?? 0)
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllRepoDetails()
    }
    fileprivate func setupTableView() {
        let productCell = UINib(nibName: "DetailRepoCell", bundle: nil)
        repoTableView.register(productCell, forCellReuseIdentifier: "DetailRepoCell")
        repoTableView.estimatedRowHeight = UITableView.automaticDimension
        repoTableView.rowHeight = UITableView.automaticDimension
        repoTableView.delegate = self
        repoTableView.dataSource = self
        repoTableView.layer.borderColor = UIColor.darkGray.cgColor
        repoTableView.layer.borderWidth = 1.0
        repoTableView.layer.cornerRadius = 10
    }
    func bindUserView() {
        loginLabel.text = ConstantIdentifiers.LoginPlaceHolder.rawValue +  (viewModel?.login ?? "login N/A")
            emailLabel.text = ConstantIdentifiers.EmailPlaceHolder.rawValue + (viewModel?.email ?? "Email N/A")
            createdLabel.text = ConstantIdentifiers.createdPlaceHolder.rawValue + (viewModel?.created?.convertDateToReadableString() ?? "Created N/A")
            followersLabel.text = ConstantIdentifiers.FollowersPlcaeHolder.rawValue + (viewModel?.followersString ?? "followers N/A")
            followingLabel.text = ConstantIdentifiers.FollowingPlaceHolder.rawValue + (viewModel?.followingString ?? "following N/A")
            locationLabel.text = ConstantIdentifiers.LocationPlaceHolder.rawValue + (viewModel?.location ?? "Location N/A")
            bioLabel.text = ConstantIdentifiers.BioPlaceHolder.rawValue + (viewModel?.bioString ?? "Bio N/A")
        userAvatarImage.loadImage(imageString: user?.avatarURL) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.userAvatarImage.image = image
            }
        }
    }
}
extension GithubUserDetailViewController: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerSearchView.header
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRepoCell", for: indexPath) as? DetailRepoCell, let instanceModel = dataSource?[indexPath.row] {
                cell.repoNameLabel.text = instanceModel.repoName
            cell.forksLabel.text = ConstantIdentifiers.ForkPlaceHolder.rawValue + "\(instanceModel.forks)"
                cell.starsLabel.text = ConstantIdentifiers.StarsPlaceHolder.rawValue + "\(instanceModel.stars)"
                return cell
        }
        return UITableViewCell()
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedRepoURL = dataSource?[indexPath.row].htmlURL {
            let safariController = SFSafariViewController(url: selectedRepoURL)
            present(safariController, animated: true, completion: nil)

        }
    }
}
extension GithubUserDetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(ConstantNumber.TimerInterval.rawValue), repeats: false, block: { [weak self] _ in
            if searchText != "" {
                  NetworkLayer().getResponseForUrl(urlString: ConstantIdentifiers.BaseRepoSearchURL.rawValue + "\(searchText)+user:\(self?.user?.login ?? "")", RepositoryServiceModel.self) { (data, error) in
                    if error != nil {
                        
                    } else {
                      self?.dataSource = data?.items
                        DispatchQueue.main.async {
                          self?.headerSearchView.titleLabel.text = (self?.headerSearchString ?? "") + String(self?.dataSource?.count ?? 0)
                          self?.repoTableView.reloadData()
                        }
                    }
                }
            } else {
                self?.getAllRepoDetails()
            }

        })

    }
}
