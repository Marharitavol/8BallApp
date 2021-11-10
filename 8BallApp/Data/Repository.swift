//
//  Repository.swift
//  8BallApp
//
//  Created by Rita on 07.11.2021.
//

import UIKit

protocol RepositoryProtocol {
    func fetchData(completion: @escaping (_ answer: String?) -> Void)
    func saveAnswerToBD(_ answer: String)
    func changeCurrentAnswer(_ answer: String)
    func getAnswersFromBD() -> [String]
    func getCurrentAnswer() -> String
}

class Repository: RepositoryProtocol {
    private let networkDataProvider: NetworkDataProvider
    private var dBProvider: DBProvider

    private var currentAnswer = "from API"

    init(networkDataProvider: NetworkDataProvider = NetworkClient(), dBProvider: DBProvider = UserDefaultsManager()) {
        self.networkDataProvider = networkDataProvider
        self.dBProvider = dBProvider
    }

    func fetchData(completion: @escaping (_ answer: String?) -> Void) {
        guard currentAnswer == "from API" else {
            completion(currentAnswer)
            return
        }

        networkDataProvider.fetchData { (answer) in
            completion(answer)
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
}
