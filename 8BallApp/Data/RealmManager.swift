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
    func fetchAnswerArray() -> Results<History>
}

class RealmManager: HistoryDBProvider {
    func saveHistory(_ history: History) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                let localRealm = try! Realm()
                try! localRealm.write {
                    localRealm.add(history)
                }
            }
        }
    }

    func fetchHistory() -> Results<History> {
        DispatchQueue.global(qos: .background).sync {
            let localRealm = try! Realm()
            return localRealm.objects(History.self).filter("isLocal == false")
        }
    }
    
    func fetchAnswerArray() -> Results<History> {
        DispatchQueue.global(qos: .background).sync {
            let localRealm = try! Realm()
            return localRealm.objects(History.self).filter("isLocal == true")
        }
    }
}
