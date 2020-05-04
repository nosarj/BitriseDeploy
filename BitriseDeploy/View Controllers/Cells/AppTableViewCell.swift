//
//  AppTableViewCell.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 04/05/2020.
//  Copyright © 2020 Yishai R. All rights reserved.
//

import UIKit

class AppTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var app: App? { didSet {
        refresh()
        }}

    private func refresh() {
        titleLabel.text = app?.title
        if let url = URL(string: app?.avatarURL ?? "") {
            avatarImageView.setImage(with: url, placeholder: UIImage(systemName: "circle.grid.3x3"))
        }
    }
}
