//
//  Repository.swift
//  8BallApp
//
//  Created by Rita on 07.11.2021.
//

import Foundation

protocol RepositoryProtocol {
    func fetchData(completion: @escaping (_ answer: String?) -> Void)
    func saveAnswerToBD(_ answer: String)
    func changeCurrentAnswer(_ answer: String)
    func getAnswersFromBD(completion: @escaping (_ answers: [String]?) -> Void)
    func getCurrentAnswer() -> String
    func getHistoryFromBD(completion: @escaping (_ historyArray: [History]?) -> Void)
    func saveHistory(_ history: History)
}

class Repository: RepositoryProtocol {
    private let networkDataProvider: NetworkDataProvider
    private var historyDBProvider: HistoryDBProvider

    private var currentAnswer = L10n.fromAPI

    init(networkDataProvider: NetworkDataProvider = NetworkClient(),
         realmManager: RealmManager = RealmManager()) {
        self.networkDataProvider = networkDataProvider
        self.historyDBProvider = realmManager
        
    }

    func fetchData(completion: @escaping (_ answer: String?) -> Void) {
        guard currentAnswer == L10n.fromAPI else {
            completion(currentAnswer)
            return
        }

        networkDataProvider.fetchData { (answer) in
            if let answer = answer {
                completion(answer)
            } else {
//                DispatchQueue.main.async {
//                    let localAnswer = self.getHistoryFromBD().randomElement()?.answer
//                    completion(localAnswer)
//                }
            }
        }
    }

    func saveAnswerToBD(_ answer: String) {
        historyDBProvider.saveHistory(History(answer: answer, isLocal: true))
    }

    func changeCurrentAnswer(_ answer: String) {
        currentAnswer = answer
    }

    func getAnswersFromBD(completion: @escaping (_ answers: [String]?) -> Void) {
        historyDBProvider.fetchLocalHistory { (historyArray) in
            guard let historyArray = historyArray else { return }
            let answers = historyArray.map { (history) in
                return history.answer
            }
            completion(answers)
        }
    }

    func getCurrentAnswer() -> String {
        currentAnswer
    }
    
    func getHistoryFromBD(completion: @escaping (_ historyArray: [History]?) -> Void) {
        historyDBProvider.fetchHistory { (historyArray) in
            completion(historyArray)
        }
    }
    
    func saveHistory(_ history: History) {
        historyDBProvider.saveHistory(history)
    }
}
