//
//  Formatters.swift
//  8BallApp
//
//  Created by Rita on 28.11.2021.
//

import Foundation

enum Formatters {
    enum Date {
        static let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            return formatter
        }()
    }
}
