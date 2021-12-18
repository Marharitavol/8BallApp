//
//  Repository.swift
//  8BallApp
//
//  Created by Rita on 07.11.2021.
//

import Foundation
import RxSwift

protocol RepositoryProtocol {
    func fetchData() -> Observable<String?>
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
    private let disposeBag = DisposeBag()

    init(networkDataProvider: NetworkDataProvider = NetworkClient(),
         realmManager: RealmManager = RealmManager()) {
        self.networkDataProvider = networkDataProvider
        self.historyDBProvider = realmManager
        
    }

    func fetchData() -> Observable<String?> {
        return Observable.create { [weak self] (observer) in
            guard let self = self else { return Disposables.create() }
            guard self.currentAnswer == L10n.fromAPI else {
                observer.on(.next(self.currentAnswer))
                return Disposables.create()
            }
            
            self.networkDataProvider.fetchData()
                .subscribe { [weak self] (answer) in
                    if let answer = answer {
                        observer.on(.next(answer))
                    } else {
                        self?.getHistoryFromBD { (history) in
                            let localAnswer = history?.randomElement()?.answer
                            observer.on(.next(localAnswer))
                        }
                    }
                } onError: { (error) in
                    print(error)
                }
                .disposed(by: self.disposeBag)
            return Disposables.create()
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
