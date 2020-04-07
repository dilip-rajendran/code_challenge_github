//
//  DetailRepoCell.swift
//  code_challenge
//
//  Created by Dilip on 4/6/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation
import UIKit
class DetailRepoCell: UITableViewCell {

  @IBOutlet weak var repoNameLabel: UILabel!
  @IBOutlet weak var forksLabel: UILabel!
  @IBOutlet weak var starsLabel: UILabel!
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
    forksLabel.font = UIFont.systemFont(ofSize: 14)
    starsLabel.font = UIFont.systemFont(ofSize: 14)
  }

}
