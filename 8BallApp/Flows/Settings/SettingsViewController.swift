//
//  SettingsViewController.swift
//  8BallApp
//
//  Created by Rita on 20.10.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {
    private let viewModel: SettingsViewModel
    private let identifier = String(describing: UITableViewCell.self)

    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupTableView()
        selectRow()
        setupBindigns()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateAnswers { [weak self] (hasAnswersUpdated) in
            guard let self = self, hasAnswersUpdated else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func selectRow() {
        let index = viewModel.currentRow()
        tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
    }
    
    private func setupBindigns() {
        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.answerAddTapped()
            })
            .disposed(by: disposeBag)
    }
    
    private func answerAddTapped() {
        let alertController = UIAlertController(title: L10n.alertTitle, message: nil, preferredStyle: .alert)

        alertController.addTextField(configurationHandler: nil)

        let okAction = UIAlertAction(title: L10n.alertOk, style: .default) { (_) in
            guard let text = alertController.textFields?.first?.text else { return }
            self.viewModel.saveAnswerToBD(text)
            self.tableView.reloadData()
            self.selectRow()
        }

        let cancelAction = UIAlertAction(title: L10n.alertCancel, style: .cancel)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension SettingsViewController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        tableView.backgroundColor = Asset.purple.color
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    private func setupNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .add,
            style: .done,
            target: self,
            action: nil)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfAnswers()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath)
        let answer = viewModel.answer(at: indexPath.row)

        cell.textLabel?.text = answer
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectAnswer(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return L10n.settingsHeader
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
