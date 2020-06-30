//
//  AuthorFilterViewController.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 20/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import UIKit

class AuthorFilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var authorList: [String] = []
    var selectedAuthors: [String] = []
    typealias DataSource = UITableViewDiffableDataSource<Section, String>
    lazy var dataSource: DataSource? = makeDataSource()
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, String>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
        configureSelectedAuthors()
        configureTableView()
        update()
    }

    private func applyStyling() {
        title = "Author List"
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 40
        tableView.register(UINib(nibName: "InfoFooterView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "FooterView")
    }
    
    private func configureSelectedAuthors() {
        if let filteredAuthors = UserDefaults.standard.array(forKey: "filteredAuthors") as? [String], filteredAuthors.count > 0 {
            selectedAuthors = filteredAuthors
        } else {
            selectedAuthors = authorList
        }
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(selectedAuthors, forKey: "filteredAuthors")
        performSegue(withIdentifier: "UnwindToBuildListFromAuthor", sender: self)
    }
}

extension AuthorFilterViewController: UITableViewDelegate {

    func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView, cellProvider: { [self] (tableView, indexPath, author) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
            cell.textLabel?.text = author
            if selectedAuthors.contains(author) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        })
        return dataSource
    }
    
    func update() {
        var newSnapshot = NSDiffableDataSourceSnapshot<Section, String>()
        newSnapshot.appendSections([.main])
        newSnapshot.appendItems(authorList, toSection: .main)
        currentSnapshot = newSnapshot
        self.dataSource?.apply(newSnapshot, animatingDifferences: true)
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterView") as? InfoFooterView else { return nil }
            footer.titleLabel.text = "Only builds from pull requests have authors. You will still view builds from other sources that have no author"
            footer.backgroundColor = .systemGray
            return footer
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
