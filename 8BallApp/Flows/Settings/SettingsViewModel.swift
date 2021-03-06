//
//  SettingsViewModel.swift
//  8BallApp
//
//  Created by Rita on 13.11.2021.
//

class SettingsViewModel {
    private let model: SettingsModel
    private var answers = [String]()
    
    init(model: SettingsModel) {
        self.model = model
    }
    
    func currentRow() -> Int {
        let selectedIndex = answers.firstIndex(of: model.getCurrentAnswer()) ?? 0
        return selectedIndex
    }
    
    func selectAnswer(at index: Int) {
        let answer = answers[index]
        model.changeCurrentAnswer(answer)
    }
    
    func saveAnswerToBD(_ answer: String) {
        model.saveAnswerToBD(answer)
        answers.append(answer)
    }
    
    func numberOfAnswers() -> Int {
        return answers.count
    }
    
    func answer(at index: Int) -> String {
        let answer = answers[index]
        return answer
    }
    
    func updateAnswers(completion: @escaping (_ answer: Bool) -> Void) {
        model.getAnswersFromBD { [weak self] (answerArray) in
            guard let self = self, let answerArray = answerArray else { return }
            self.answers = answerArray
            completion(true)
        }
    }
}
