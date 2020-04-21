//
//  BuildTableViewCell.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import UIKit

protocol BuildTableViewCellDelegate: class {
    func buildTableViewCellInstallPageButtonDidTap(build: Build)
}

class BuildTableViewCell: UITableViewCell {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var commitMessageLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var installPageButton: UIButton!

    weak var delegate: BuildTableViewCellDelegate?

    override func awakeFromNib() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .medium)
        let installIcon = UIImage(systemName: "square.and.arrow.down.fill", withConfiguration: largeConfig)
        installPageButton.setImage(installIcon, for: .normal)
    }

    var build: Build? { didSet {
        refresh()
        }}

    private func refresh() {
        versionLabel.text = build?.version
        if let buildNumber = build?.buildNumber, let versionNumber = build?.version, let author = build?.originalBuildParams.pullRequestAuthor {
            versionLabel.text = "\(versionNumber) (\(buildNumber)) - \(author)"
        }
        commitMessageLabel.text = build?.commitMessage
//        authorLabel.text =
    }

    @IBAction func intallPageButtonTapped(_ sender: Any) {
        if let build = build {
            delegate?.buildTableViewCellInstallPageButtonDidTap(build: build)
        }
    }
}