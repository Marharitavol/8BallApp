//
//  BallModel.swift
//  8BallApp
//
//  Created by Rita on 13.11.2021.
//

class BallModel {
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchData(completion: @escaping (_ answer: String?) -> Void) {
        repository.fetchData { (answer) in
            completion(answer)
        }
    }
    
    func getSettingModel() -> SettingsModel {
        return SettingsModel(repository: repository)
    }
}
