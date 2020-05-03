//
//  BuildTableViewCell.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import UIKit

class BuildTableViewCell: UITableViewCell {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var commitMessageLabel: UILabel!
    @IBOutlet weak var buildNumberView: UIView!
    @IBOutlet weak var buildNumberLabel: UILabel!
    @IBOutlet weak var authorView: UIView!
    @IBOutlet weak var authorIcon: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    var build: Build? { didSet {
        refresh()
        }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling()
    }
    
    private func applyStyling() {
        setBuildNumberStyling()
    }
    
    private func setBuildNumberStyling() {
        buildNumberView.layer.borderColor = UIColor.link.cgColor
        buildNumberView.layer.borderWidth = 1.5
        buildNumberView.layer.cornerRadius = 8
    }

    private func refresh() {
        versionLabel.text = build?.version
        if let versionNumber = build?.version {
            versionLabel.text = "\(versionNumber)"
        }
        if let buildNumber = build?.buildNumber {
            buildNumberLabel.text = " #\(buildNumber) "
        }
        if let author = build?.originalBuildParams?.pullRequestAuthor {
            authorLabel.text = author
            authorView.isHidden = false
        } else {
            authorView.isHidden = true
        }
        commitMessageLabel.text = build?.branch
    }
}
