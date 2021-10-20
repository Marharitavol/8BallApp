//
//  UserDefaultsManager.swift
//  8BallApp
//
//  Created by Rita on 20.10.2021.
//

import Foundation

class UserDefaultsManager {
    
    private let defaults = UserDefaults.standard
}

extension UserDefaultsManager {
    
    var answerArray: [String] {
        get {
            return defaults.object(forKey: "answerArray") as? [String] ?? ["from API", "Just do it!", "Change your mind"]
        }
        set {
            defaults.set(newValue, forKey: "answerArray")
        }
    }
}
