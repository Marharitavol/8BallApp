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
        guard answer == L10n.fromAPI else {
            return Observable.create { (observer) in
                observer.on(.next(self.answer))
                return Disposables.create()
            }
        }
        
        guard let url = URL(string: "https://8ball.delegator.com/magic/JSON/question") else {
            return Observable.create { (observer) in
                observer.on(.next(nil))
                return Disposables.create()
            }
        }
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw FetchError.invalidResponse(result.response)
                }
                return result.data
            }.map { data in
                do {
                    let apiResponse = try JSONDecoder().decode(
                        ApiResponse.self, from: data
                    )
                    let answer = apiResponse.magic.answer
                    return answer
                } catch let error {
                    throw FetchError.invalidJSON(error)
                }
            }
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
}
