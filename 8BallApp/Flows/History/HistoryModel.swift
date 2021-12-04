//
//  HistoryModel.swift
//  8BallApp
//
//  Created by Rita on 24.11.2021.
//

class HistoryModel {
    
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func getHistoryFromBD(completion: @escaping (_ historyArray: [History]?) -> Void) {
        repository.getHistoryFromBD { (historyArray) in
            completion(historyArray)
        }
    }
}
