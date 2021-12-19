//
//  AppFlowCoordinator.swift
//  8BallApp
//
//  Created by Rita on 19.12.2021.
//

import UIKit

final class AppFlowCoordinator: FlowCoordinator {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        let tabBarController = UITabBarController()
        super.init(viewController: tabBarController)
        
        self.setupTabBarController(tabBarController: tabBarController)
    }
    
    private func setupTabBarController(tabBarController: UITabBarController) {
        let navigationController = setupBallScreen()
        let historyVC = setupHistoryScreen()
        tabBarController.setViewControllers([navigationController, historyVC], animated: true)
    }
    
    private func setupBallScreen() -> UIViewController {
        let rootViewController = BallFlowCoordinator(repository: repository).viewController
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: L10n.clock),
            selectedImage: nil)
        navigationController.title = L10n.main
        return navigationController
    }
    
    private func setupHistoryScreen() -> UIViewController {
        let historyViewController = HistoryFlowCoordinator(repository: repository).viewController
        historyViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: L10n.starCircleFill),
            selectedImage: nil)
        historyViewController.title = L10n.history
        return historyViewController
    }
}
