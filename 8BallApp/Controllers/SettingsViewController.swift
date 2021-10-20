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
    
    private var array = ["from API", "Just do it!", "Change your mind"]
    
    private let answerManager = AnswerManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        selectRow()
    }
    
    @IBAction func answerAddTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Create new answer", message: nil, preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nil)
        
        let okAction = UIAlertAction(title: "Create", style: .default) { (action) in
            guard let text = alertController.textFields?.first?.text else { return }
            self.array.append(text)
            self.tableView.reloadData()
            self.selectRow()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func selectRow() {
        let selectedIndex = array.firstIndex(of: answerManager.answer) ?? 0
        tableView.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: .middle)
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let answer = array[indexPath.row]
        
        cell.textLabel?.text = answer
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(array[indexPath.row])
        answerManager.answer = array[indexPath.row]
    }
}
