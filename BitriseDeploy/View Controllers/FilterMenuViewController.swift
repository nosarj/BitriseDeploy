//
//  FilterMenuViewController.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 22/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import UIKit

class FilterMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var app: App?
    var authorList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
        configureTableView()
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? AuthorFilterViewController {
                destination.authorList = authorList
            } else if let destination = segue.destination as? WorkflowFilterViewController {
                destination.app = app
            }
        }
    
    private func applyStyling() {
        title = "Filter Menu"
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension FilterMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle") else { return UITableViewCell() }
        if indexPath.row == 1 {
            cell.textLabel?.text = "Pull Request Authors"
            cell.detailTextLabel?.text = ""
        } else {
            cell.textLabel?.text = "Workflows"
            cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "selectedWorkflow")
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            performSegue(withIdentifier: "AuthorFilterSegue", sender: self)
        } else {
            performSegue(withIdentifier: "WorkflowFilterSegue", sender: self)
        }
    }
}
