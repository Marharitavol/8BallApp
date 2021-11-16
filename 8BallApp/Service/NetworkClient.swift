//
//  NetworkManager.swift
//  8BallApp
//
//  Created by Rita on 19.10.2021.
//

import UIKit

protocol NetworkDataProvider {
    func fetchData(completion: @escaping (_ answer: String?) -> Void)
}

class NetworkClient: NetworkDataProvider {

    var answer = L10n.fromAPI

    func fetchData(completion: @escaping (_ answer: String?) -> Void) {

        guard answer == L10n.fromAPI else {
            completion(answer)
            return
        }

        guard let url = URL(string: "https://8ball.delegator.com/magic/JSON/question") else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(ApiResponse.self, from: data)
                let answer = apiResponse.magic.answer
                completion(answer)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
