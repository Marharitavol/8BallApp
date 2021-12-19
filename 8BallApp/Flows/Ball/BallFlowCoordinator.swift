//
//  BallFlowCoordinator.swift
//  8BallApp
//
//  Created by Rita on 19.12.2021.
//

import UIKit

final class BallFlowCoordinator: FlowCoordinator {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        let ballVC = BallViewController()
        super.init(viewController: ballVC)
        
        let model = BallModel(repository: repository)
        let viewModel = BallViewModel(model: model, flowCoordinator: self)
        ballVC.viewModel = viewModel
    }
}

extension BallFlowCoordinator {
    func openSettings() {
        let settingsVC = SettingsFlowCoordinator(repository: repository).viewController
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}
