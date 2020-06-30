//
//  AppListViewController.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 03/05/2020.
//  Copyright © 2020 Yishai R. All rights reserved.
//

import UIKit

enum Section: CaseIterable {
    case main
}

class AppListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var apps = [App]()
    var selectedApp: App?
    typealias DataSource = UITableViewDiffableDataSource<Section, App>
    lazy var dataSource: DataSource? = makeDataSource()
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, App>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        applyStyling()
        showOnboardingIfRequired()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? BuildListViewController else { return }
        destination.app = selectedApp
    }
    
    private func applyStyling() {
        title = "Apps List"
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "AppTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AppListCell")
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(downloadAppList), for: .valueChanged)
    }
    
    @IBAction func unwindToAppListWithRefresh(segue:UIStoryboardSegue) {
         manualRefresh()
     }
    
    private func showOnboardingIfRequired() {
        if (try? KeychainService.loadPassword()) == nil {
            performSegue(withIdentifier: "OnboardingSegue", sender: self)
        } else {
            downloadAppList()
        }
    }
    
    private func manualRefresh() {
        downloadAppList()
        let offsetPoint = CGPoint.init(x: 0, y: -refreshControl.frame.size.height)
        tableView.setContentOffset(offsetPoint, animated: true)
    }
    
    @objc private func downloadAppList() {
        refreshControl.beginRefreshing()
        AppListService.downloadIOSAppList { [self] (result) in
            switch result {
            case .failure( let error):
                showErrorAlert(error)
            case .success(let downloadedApps):
                DispatchQueue.main.async { [self] in
                    apps = downloadedApps
                    refreshControl.endRefreshing()
                    update()
                }
            }
        }
    }
    
    private func showErrorAlert(_ error: (Error)) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension AppListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let app = dataSource?.itemIdentifier(for: indexPath) else {
          return
        }
        selectedApp = app
        performSegue(withIdentifier: "BuildListSegue", sender: self)
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, app) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppListCell", for: indexPath) as? AppTableViewCell else {
                fatalError("Unable to dequeue Build Cell")
            }
            cell.app = app
            return cell
        })
        return dataSource
    }
    
    func update() {
        var newSnapshot = NSDiffableDataSourceSnapshot<Section, App>()
        newSnapshot.appendSections([.main])
        newSnapshot.appendItems(apps, toSection: .main)
        currentSnapshot = newSnapshot
        self.dataSource?.apply(newSnapshot, animatingDifferences: true)
    }
}
