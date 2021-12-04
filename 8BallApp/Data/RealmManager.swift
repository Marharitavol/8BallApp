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
    func fetchHistory(completion: @escaping (_ historyArray: [History]?) -> Void)
    func fetchLocalHistory(completion: @escaping (_ historyArray: [History]?) -> Void)
}

class RealmManager: HistoryDBProvider {
    func saveHistory(_ history: History) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let localRealm = try Realm()
                    try localRealm.write {
                        localRealm.add(history)
                        localRealm.refresh()
                    }
                } catch {
                    print("save Error")
                }
            }
        }
    }
    
    func fetchHistory(completion: @escaping (_ historyArray: [History]?) -> Void) {
        DispatchQueue.global(qos: .background).sync {
            do {
                let localRealm = try Realm()
                let historyResults = localRealm.objects(History.self).filter("isLocal == false")
                localRealm.refresh()
                completion(Array(historyResults))
            } catch {
                print("fetchHistory error")
            }
        }
    }
    
    func fetchLocalHistory(completion: @escaping (_ historyArray: [History]?) -> Void) {
        DispatchQueue.global(qos: .background).sync {
            do {
                let localRealm = try Realm()
                let answerResults = localRealm.objects(History.self).filter("isLocal == true")
                localRealm.refresh()
                completion(Array(answerResults))
            } catch {
                print("fetchAnswers error")
            }
        }
    }
}
