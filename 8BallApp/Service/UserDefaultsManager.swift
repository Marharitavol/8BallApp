//
//  UserDefaultsManager.swift
//  8BallApp
//
//  Created by Rita on 20.10.2021.
//

import Foundation

protocol DBProvider {
    var answerArray: [String] { get set }
}

class UserDefaultsManager: DBProvider {

    private let defaults = UserDefaults.standard

    var answerArray: [String] {
        get {
            let chosenAnswers = [L10n.fromAPI, L10n.justDoIt, L10n.changeYourMind]
            return defaults.object(forKey: L10n.userDefaultsKey) as? [String] ?? chosenAnswers
        }
        set {
            defaults.set(newValue, forKey: L10n.userDefaultsKey)
        }
    }
}
