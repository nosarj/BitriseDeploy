//
//  WorkflowFilterViewController.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 21/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import UIKit

class WorkflowFilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var workflowArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        applyStyling()
        downloadWorkflows()
    }
    
    private func applyStyling() {
        title = "Workflow List"
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(downloadWorkflows), for: .valueChanged)
    }
    
    @objc func downloadWorkflows() {
        refreshControl.beginRefreshing()
        WorkflowService.downloadWorkflows { (result) in
            switch result {
            case .failure( let error):
                self.showErrorAlert(error)
            case .success(let workflowsList):
                self.workflowArray = workflowsList.sorted()
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

extension WorkflowFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workflowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle") else {
            fatalError("Unable to dequeue cell")
        }
        let workflow = workflowArray[indexPath.row]
        cell.textLabel?.text = workflow
        if UserDefaults.standard.string(forKey: "selectedWorkflow") == workflow {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if cell.accessoryType == .none {
            UserDefaults.standard.set(cell.textLabel?.text, forKey: "selectedWorkflow")
            cell.accessoryType = .checkmark
        } else {
            UserDefaults.standard.set(nil, forKey: "selectedWorkflow")
            cell.accessoryType = .none
        }
    }
}
