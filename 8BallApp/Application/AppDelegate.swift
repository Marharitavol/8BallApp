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
        
        window?.rootViewController = setupTabBarController(repository: repository)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        
        return true
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
            image: UIImage(systemName: "clock"),
            selectedImage: nil)
        navigationController.title = "Main"
        return navigationController
    }
    
    private func setupHistoryScreen(repository: Repository) -> UIViewController {
        let historyModel = HistoryModel(repository: repository)
        let historyViewModel = HistoryViewModel(model: historyModel)
        let historyViewController = HistoryViewController(viewModel: historyViewModel)
        historyViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "star.circle.fill"),
            selectedImage: nil)
        historyViewController.title = "History"
        return historyViewController
    }
}
