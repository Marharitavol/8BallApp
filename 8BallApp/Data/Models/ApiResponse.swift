//
//  ApiResponse.swift
//  8BallApp
//
//  Created by Rita on 19.10.2021.
//

import Foundation

struct ApiResponse: Decodable {
    var magic: Magic
}
struct Magic: Decodable {
    var question: String?
    var answer: String?
    var type: String?
}
