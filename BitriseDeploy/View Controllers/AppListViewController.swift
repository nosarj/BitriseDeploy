//
//  AppListViewController.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 03/05/2020.
//  Copyright © 2020 Yishai R. All rights reserved.
//

import UIKit

class AppListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var apps = [App]()
    var selectedApp: App?

    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
        configureTableView()
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
        tableView.dataSource = self
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
        AppListService.downloadIOSAppList { (result) in
            switch result {
            case .failure( let error):
                self.showErrorAlert(error)
            case .success(let apps):
                self.apps = apps
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
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
}

extension AppListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppListCell", for: indexPath) as? AppTableViewCell else {
            fatalError("Unable to dequeue Build Cell")
        }
        cell.app = apps[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedApp = apps[indexPath.row]
        performSegue(withIdentifier: "BuildListSegue", sender: self)
    }
}
