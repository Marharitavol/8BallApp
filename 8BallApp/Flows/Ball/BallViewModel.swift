//
//  BallViewModel.swift
//  8BallApp
//
//  Created by Rita on 13.11.2021.
//

import Foundation

class BallViewModel {
    private let model: BallModel
    
    init(model: BallModel) {
        self.model = model
    }
    
    func shake(completion: @escaping (_ answer: String?) -> Void) {
        model.fetchData { (answer) in
            let formattedAnswer = answer?.uppercased()
            completion(formattedAnswer)
        }
    }
    
    func getSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(model: model.getSettingModel())
    }
    
    func saveHistory(_ answer: String) {
        let history = History(answer: answer, date: Date())
        model.saveHistory(history)
    }
}
