//
//  NetworkManager.swift
//  8BallApp
//
//  Created by Rita on 19.10.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol NetworkDataProvider {
    func fetchData() -> Observable<String?>
}

class NetworkClient: NetworkDataProvider {
    
    private enum FetchError: Error {
        case invalidResponse(URLResponse?)
        case invalidJSON(Error)
    }
    
    var answer = L10n.fromAPI
    
    func fetchData() -> Observable<String?> {
        return Observable.create { [weak self] (observer) in
            guard let self = self else { return Disposables.create() }
            guard self.answer == L10n.fromAPI else {
                observer.on(.next(self.answer))
                return Disposables.create()
            }
            
            guard let url = URL(string: "https://8ball.delegator.com/magic/JSON/question") else {
                observer.on(.next(nil))
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error as? URLError, error.errorCode == -1009 {
                    observer.on(.next(nil))
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(ApiResponse.self, from: data)
                    let answer = apiResponse.magic.answer
                    observer.on(.next(answer))
                } catch let error {
                    print(error)
                }
            }.resume()
            return Disposables.create()
        }
    }
}
