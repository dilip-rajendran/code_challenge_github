//
//  UserTableViewCell.swift
//  code_challenge
//
//  Created by Dilip on 4/5/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import UIKit

final class UserTableViewCell: UITableViewCell {

  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var repoCountLabel: UILabel!
  
  var user: User?

  override func prepareForReuse() {
    super.prepareForReuse()
    userImageView.image = nil
    usernameLabel.text = "UserName"
    repoCountLabel.text = "Repos Count"
  }
    
    func bindViewModel(viewModel: UserCellViewModel)  {
        
        viewModel.getUserDetails() { user,Error  in
            self.user = user
            DispatchQueue.main.async {
                self.usernameLabel.text = user?.login
                self.repoCountLabel.text = ConstantIdentifiers.RepoCountPlaceHolder.rawValue + String(user?.publicRepos ?? 0)
            }
            self.userImageView.loadImage(imageString: user?.avatarURL) {[weak self] (image) in
                            DispatchQueue.main.async {
                                self?.userImageView.layer.cornerRadius = 40
                                self?.userImageView.image = image

                }
            }
        }
    }
}
