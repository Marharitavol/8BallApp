//
//  AppDelegate.swift
//  8BallApp
//
//  Created by Rita on 19.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let repository = Repository()
        
        setupLocalAnswers(repository: repository)
        
        window?.rootViewController = setupTabBarController(repository: repository)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        
        return true
    }
    
    private func setupLocalAnswers(repository: Repository) {
        guard repository.getAnswersFromBD().isEmpty else { return }
        repository.saveHistory(History(answer: L10n.fromAPI, isLocal: true))
        repository.saveHistory(History(answer: L10n.justDoIt, isLocal: true))
        repository.saveHistory(History(answer: L10n.changeYourMind, isLocal: true))
    }
    
    private func setupTabBarController(repository: Repository) -> UITabBarController {
        let navigationController = setupBallScreen(repository: repository)
        let historyVC = setupHistoryScreen(repository: repository)
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([navigationController, historyVC], animated: true)
        return tabBarController
    }
    
    private func setupBallScreen(repository: Repository) -> UIViewController {
        let model = BallModel(repository: repository)
        let viewModel = BallViewModel(model: model)
        let rootViewController = BallViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: L10n.clock),
            selectedImage: nil)
        navigationController.title = L10n.main
        return navigationController
    }
    
    private func setupHistoryScreen(repository: Repository) -> UIViewController {
        let historyModel = HistoryModel(repository: repository)
        let historyViewModel = HistoryViewModel(model: historyModel)
        let historyViewController = HistoryViewController(viewModel: historyViewModel)
        historyViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: L10n.starCircleFill),
            selectedImage: nil)
        historyViewController.title = L10n.history
        return historyViewController
    }
}
