//
//  AuthorFilterViewController.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 20/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import UIKit

protocol AuthorFilterViewControllerDelgate: class {
    func didFilterAuthors(authors: [String])
}

class AuthorFilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var authorList: [String] = []
    var selectedAuthors: [String] = []
    weak var delegate: AuthorFilterViewControllerDelgate?

    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
        configureTableView()
    }

    private func applyStyling() {
        title = "Author List"
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        delegate?.didFilterAuthors(authors: selectedAuthors)
        navigationController?.popViewController(animated: true)
    }
}

extension AuthorFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authorList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle") else {
            fatalError("Unable to dequeue cell")
        }
        let author = authorList[indexPath.row]
        cell.textLabel?.text = author
        if selectedAuthors.contains(author) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            guard let index = selectedAuthors.firstIndex(of: authorList[indexPath.row]) else { return }
            selectedAuthors.remove(at: index)
        } else {
            cell?.accessoryType = .checkmark
            selectedAuthors.append(authorList[indexPath.row])
        }
    }
}
