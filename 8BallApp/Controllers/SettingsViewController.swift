//
//  SettingsViewController.swift
//  8BallApp
//
//  Created by Rita on 20.10.2021.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    private let tableView = UITableView()

    private var array = [String]()

    var repository: RepositoryProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        array = repository?.getAnswersFromBD() ?? [String]()

        setupTableView()
        selectRow()
    }

    @IBAction private func answerAddTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: L10n.alertTitle, message: nil, preferredStyle: .alert)

        alertController.addTextField(configurationHandler: nil)

        let okAction = UIAlertAction(title: L10n.alertOk, style: .default) { (_) in
            guard let text = alertController.textFields?.first?.text else { return }
            self.array.append(text)
            self.repository?.saveAnswerToBD(text)
            self.tableView.reloadData()
            self.selectRow()
        }

        let cancelAction = UIAlertAction(title: L10n.alertCancel, style: .cancel)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: L10n.identifier)
    }

    private func selectRow() {
        let selectedIndex = array.firstIndex(of: repository?.getCurrentAnswer() ?? "") ?? 0
        tableView.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: .none)
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.identifier, for: indexPath)
        let answer = array[indexPath.row]

        cell.textLabel?.text = answer
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repository?.changeCurrentAnswer(array[indexPath.row])
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return L10n.settingsHeader
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
