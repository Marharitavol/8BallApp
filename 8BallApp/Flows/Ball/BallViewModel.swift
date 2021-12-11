//
//  BallViewModel.swift
//  8BallApp
//
//  Created by Rita on 13.11.2021.
//

import Foundation

class BallViewModel {
    var callback: ((Bool) -> Void)?
    
    private let model: BallModel
    private var animationTimeUp = false
    private var didAnswerCome = false
    
    init(model: BallModel) {
        self.model = model
    }
    
    func shake(completion: @escaping (_ answer: String?) -> Void) {
        startTime()
        model.fetchData { [weak self] (answer) in
            guard let self = self else { return }
            self.didAnswerCome = true
            self.checkAnimationTime()
            let formattedAnswer = answer?.uppercased()
            completion(formattedAnswer)
        }
    }
    
    func getSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(model: model.getSettingModel())
    }
    
    func saveHistory(_ answer: String) {
        let history = History(answer: answer, date: Date(), isLocal: false)
        model.saveHistory(history)
    }
    
    private func startTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.animationTimeUp = true
            self.checkAnimationTime()
        }
    }
    
    private func checkAnimationTime() {
        let isReady = animationTimeUp && didAnswerCome
        guard isReady else { return }
        animationTimeUp.toggle()
        didAnswerCome.toggle()
        callback?(isReady)
    }
}
