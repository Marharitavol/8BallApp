//
//  SettingsFlowCoordinator.swift
//  8BallApp
//
//  Created by Rita on 19.12.2021.
//

import UIKit
import RxSwift

final class SettingsFlowCoordinator: FlowCoordinator {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        let settingsVC = SettingsViewController()
        super.init(viewController: settingsVC)
        
        let model = SettingsModel(repository: repository)
        let viewModel = SettingsViewModel(model: model)
        settingsVC.viewModel = viewModel
    }
}
