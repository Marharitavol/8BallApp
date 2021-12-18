//
//  BallViewModel.swift
//  8BallApp
//
//  Created by Rita on 13.11.2021.
//

import Foundation
import RxSwift

class BallViewModel {
    var callback: ((Bool) -> Void)?
    
    private let model: BallModel
    private var animationTimeUp = false
    private var didAnswerCome = false
    private let disposeBag = DisposeBag()
    
    init(model: BallModel) {
        self.model = model
    }
    
    func shake() -> Observable<String?> {
        startTime()
        return Observable.create { [weak self] (observer) in
            guard let self = self else { return Disposables.create() }
            self.model.fetchData()
                .subscribe { [weak self] (answer) in
                    guard let self = self else { return }
                    self.didAnswerCome = true
                    self.checkAnimationTime()
                    let formattedAnswer = answer?.uppercased()
                    observer.on(.next(formattedAnswer))
                } onError: { (error) in
                    print(error)
                }
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func getSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(model: model.getSettingModel())
    }
    
    func saveHistory(_ answer: String) {
        let history = History(answer: answer, date: Date(), isLocal: false)
        model.saveHistory(history)
    }
    
    private func startTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.animationTimeUp = true
            self.checkAnimationTime()
        }
    }
    
    private func checkAnimationTime() {
        let isReady = animationTimeUp && didAnswerCome
        guard isReady else { return }
        animationTimeUp.toggle()
        didAnswerCome.toggle()
        callback?(isReady)
    }
}
