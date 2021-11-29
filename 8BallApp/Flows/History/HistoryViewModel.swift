//
//  HistoryViewModel.swift
//  8BallApp
//
//  Created by Rita on 24.11.2021.
//
import Foundation

class HistoryViewModel {
    
    private let model: HistoryModel
    private var history: [History]
    
    init(model: HistoryModel) {
        self.model = model
        self.history = model.getHistoryFromBD()
    }
    
    func numberOfHistory() -> Int {
        return history.count
    }
    
    func history(at index: Int) -> String {
        let formatter = Formatters.Date.formatter
        let date = formatter.string(from: history[index].date)
        let answer = history[index].answer + "  \(String(describing: date))"
        return answer
    }
    
    func updateHistory() {
        let historyFromBD = model.getHistoryFromBD()
        history = historyFromBD.reversed()
    }
}
