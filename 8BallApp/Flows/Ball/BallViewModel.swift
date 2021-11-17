//
//  BallViewModel.swift
//  8BallApp
//
//  Created by Rita on 13.11.2021.
//

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
}
