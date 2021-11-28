//
//  HistoryModel.swift
//  8BallApp
//
//  Created by Rita on 23.11.2021.
//

import RealmSwift

class History: Object {
    
    @objc dynamic var answer: String = ""
    @objc dynamic var date = Date()
    @objc dynamic var isLocal: Bool = false
    
    convenience init(answer: String, date: Date = Date(), isLocal: Bool) {
        self.init()
        self.answer = answer
        self.date = date
        self.isLocal = isLocal
    }
}
