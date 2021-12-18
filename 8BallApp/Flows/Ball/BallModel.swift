//
//  BallModel.swift
//  8BallApp
//
//  Created by Rita on 13.11.2021.
//

import RxSwift

class BallModel {
    private let repository: RepositoryProtocol
    
    private let disposeBag = DisposeBag()
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchData() -> Observable<String?> {
        return repository.fetchData()
    }
    
    func getSettingModel() -> SettingsModel {
        return SettingsModel(repository: repository)
    }
    
    func saveHistory(_ history: History) {
        repository.saveHistory(history)
    }
}
