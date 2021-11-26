//
//  RealmManager.swift
//  8BallApp
//
//  Created by Rita on 23.11.2021.
//
//
import RealmSwift

protocol HistoryDBProvider {
    func saveHistory(_ history: History)
    func fetchHistory() -> Results<History>
}

class RealmManager: HistoryDBProvider {
    let localRealm = try! Realm()

    func saveHistory(_ history: History) {
        try! localRealm.write {
            localRealm.add(history)
        }
    }

    func fetchHistory() -> Results<History> {
        return localRealm.objects(History.self)
    }
}
