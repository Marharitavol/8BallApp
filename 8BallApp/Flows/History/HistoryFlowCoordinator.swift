//
//  HistoryFlowCoordinator.swift
//  8BallApp
//
//  Created by Rita on 19.12.2021.
//

import UIKit

final class HistoryFlowCoordinator: FlowCoordinator {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        let historyVC = HistoryViewController()
        super.init(viewController: historyVC)
        
        let model = HistoryModel(repository: repository)
        let viewModel = HistoryViewModel(model: model)
        historyVC.viewModel = viewModel
    }
}
