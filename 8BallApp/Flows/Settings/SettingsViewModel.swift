//
//  SettingsViewModel.swift
//  8BallApp
//
//  Created by Rita on 13.11.2021.
//

class SettingsViewModel {
    private let model: SettingsModel
    private var answers: [String]
    
    init(model: SettingsModel) {
        self.model = model
        self.answers = model.getAnswersFromBD()
    }
    
    func fetchData(completion: @escaping (_ answer: String?) -> Void) {
        model.fetchData { (answer) in
            completion(answer)
        }
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
}
