//
//  HistoryViewController.swift
//  8BallApp
//
//  Created by Rita on 24.11.2021.
//

import UIKit
import SnapKit
import SystemConfiguration

class HistoryViewController: UIViewController {
    
    private let viewModel: HistoryViewModel
    
    private let tableView = UITableView()
    private let identifier = String(describing: UITableViewCell.self)
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateHistory { (hasHistoryUpdated) in
            guard hasHistoryUpdated else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        tableView.backgroundColor = Asset.purple.color
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        let identifier = String(describing: UITableViewCell.self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfHistory()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: UITableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.selectionStyle = .none
        
        let answer = viewModel.history(at: indexPath.row)
        cell.textLabel?.text = answer
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return L10n.history
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
