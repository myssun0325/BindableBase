//
//  NewFeatureViewModel.swift
//  BindableBase
//
//  Created by Mason on 2023/05/10.
//

import Foundation
import RxSwift
import RxRelay

class NewFeatureViewModel: BaseViewModel {
    
    enum Signal: BaseSignal {
        case custom
    }
    
    struct Input {
        let fetch = PublishRelay<Void>()
    }
    
    struct Output {
        let text: Observable<String?>
    }
    
    struct State {
        let text: BehaviorRelay<String?>
    }
    
    let input = Input()
    let state: State
    let output: Output
    
    override init() {
        self.state = State(text: .init(value: nil))
        self.output = Output(text: state.text.asObservable())
        super.init()
        
        input.fetch
            .map { "Result" }
            .bind(to: state.text)
            .disposed(by: disposeBag)
        
        input.fetch
            .map { _ in ErrorSignal.api }
            .bind(to: _signal)
            .disposed(by: disposeBag)
        
        state.text
            .filter { $0?.count ?? 0 > 10 }
            .map { _ in Signal.custom }
            .bind(to: _signal)
            .disposed(by: disposeBag)
    }
}
