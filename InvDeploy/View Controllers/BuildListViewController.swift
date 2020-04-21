//
//  ViewController.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import UIKit
import SafariServices

class BuildListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var builds = [Build]()
    var filteredAuthors: [String]?
    var filteredBuilds: [Build] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
        configureTableView()
        showOnboardingIfRequired()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AuthorFilterViewController else { return }
        let authorsList = Array(AuthorService.configureAuthorList(builds: builds))
        destination.selectedAuthors = filteredAuthors ?? authorsList
        destination.authorList = authorsList
        destination.delegate = self
    }

    @IBAction func unwindToBuildList(segue:UIStoryboardSegue) {
        manualRefresh()
    }

    private func applyStyling() {
        title = "Builds List"
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "BuildTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BuildCell")
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(downloadBuilds), for: .valueChanged)
    }

    private func showOnboardingIfRequired() {
        if (try? KeychainService.loadPassword()) == nil {
            performSegue(withIdentifier: "OnboardingSegue", sender: self)
        } else {
            downloadBuilds()
        }
    }

    private func manualRefresh() {
        downloadBuilds()
        let offsetPoint = CGPoint.init(x: 0, y: -refreshControl.frame.size.height)
        tableView.setContentOffset(offsetPoint, animated: true)
    }

    @objc private func downloadBuilds() {
        refreshControl.beginRefreshing()
        BuildService().downloadBuilds { (result) in
            switch result {
            case .failure( let error):
                self.showErrorAlert(error)
            case .success(let builds):
                self.builds = builds
                self.filterBuilds()
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }

    private func filterBuilds() {
        filteredBuilds = builds
        for build in builds {
            if let filteredAuthors = filteredAuthors {
                if !filteredAuthors.contains(build.originalBuildParams.pullRequestAuthor) {
                    filteredBuilds.removeAll { $0 == build }
                }
            }
        }
    }

    private func showErrorAlert(_ error: (Error)) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func filterButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "FilterSegue", sender: self)
    }
}

extension BuildListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBuilds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BuildCell", for: indexPath) as? BuildTableViewCell else {
            fatalError("Unable to dequeue Build Cell")
        }
        cell.build = filteredBuilds[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension BuildListViewController: BuildTableViewCellDelegate {
    func buildTableViewCellInstallPageButtonDidTap(build: Build) {
        guard let url = URL(string: build.app?.publicInstallPageURL ?? "") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension BuildListViewController: AuthorFilterViewControllerDelgate {
    func didFilterAuthors(authors: [String]) {
        filteredAuthors = authors
        filterBuilds()
        tableView.reloadData()
    }
}
