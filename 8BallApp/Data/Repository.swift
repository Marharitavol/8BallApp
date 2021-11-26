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
    func getAnswersFromBD() -> [String]
    func getCurrentAnswer() -> String
    func getHistoryFromBD() -> [History]
    func saveHistory(_ history: History)
}

class Repository: RepositoryProtocol {
    private let networkDataProvider: NetworkDataProvider
    private var dBProvider: DBProvider
    private var historyDBProvider: HistoryDBProvider

    private var currentAnswer = L10n.fromAPI

    init(networkDataProvider: NetworkDataProvider = NetworkClient(),
         dBProvider: DBProvider = UserDefaultsManager(),
         realmManager: RealmManager = RealmManager()) {
        self.networkDataProvider = networkDataProvider
        self.dBProvider = dBProvider
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
                DispatchQueue.main.async {
                    let localAnswer = self.getHistoryFromBD().randomElement()?.answer
                    completion(localAnswer)
                }
            }
        }
    }

    func saveAnswerToBD(_ answer: String) {
        dBProvider.answerArray.append(answer)
    }

    func changeCurrentAnswer(_ answer: String) {
        currentAnswer = answer
    }

    func getAnswersFromBD() -> [String] {
        dBProvider.answerArray
    }

    func getCurrentAnswer() -> String {
        currentAnswer
    }
    
    func getHistoryFromBD() -> [History] {
        historyDBProvider.fetchHistory().map { (history) in
            return history
        }
    }
    
    func saveHistory(_ history: History) {
        historyDBProvider.saveHistory(history)
    }
}
