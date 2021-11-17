//
//  SettingsModel.swift
//  8BallApp
//
//  Created by Rita on 13.11.2021.
//

class SettingsModel {
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchData(completion: @escaping (_ answer: String?) -> Void) {
        repository.fetchData { (answer) in
            completion(answer)
        }
    }
    
    func getAnswersFromBD() -> [String] {
        repository.getAnswersFromBD()
    }
    
    func getCurrentAnswer() -> String {
        repository.getCurrentAnswer()
    }
    
    func changeCurrentAnswer(_ answer: String) {
        repository.changeCurrentAnswer(answer)
    }
    
    func saveAnswerToBD(_ answer: String) {
        repository.saveAnswerToBD(answer)
    }
}
