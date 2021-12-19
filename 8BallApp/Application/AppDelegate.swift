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
        
        window?.rootViewController = AppFlowCoordinator(repository: repository).viewController
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        
        return true
    }
    
    private func setupLocalAnswers(repository: Repository) {
        repository.getAnswersFromBD { (answers) in
            guard answers == nil || (answers ?? []).isEmpty else { return }
            repository.saveHistory(History(answer: L10n.fromAPI, isLocal: true))
            repository.saveHistory(History(answer: L10n.justDoIt, isLocal: true))
            repository.saveHistory(History(answer: L10n.changeYourMind, isLocal: true))
        }
    }
}
