//
//  Mason.swift
//  BindableBase
//
//  Created by Mason on 2023/05/11.
//

import Foundation
import RxSwift
import RxRelay

protocol ViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    associatedtype State
    
    var input: Input { get }
    var output: Output { get }
    var state: State { get }
}

class SignalBase {
    let disposeBag = DisposeBag()
    let signal: Observable<BaseSignal>
    let _signal = PublishSubject<BaseSignal>()
    
    init() {
        signal = _signal.asObservable()
    }
}

typealias MasonViewModel = SignalBase & ViewModelType

final class MasonFeatureViewModel: MasonViewModel {
    
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
    let output: Output
    let state: State
    
    override init() {
        state = State(text: .init(value: nil))
        output = Output(text: state.text.asObservable())
        super.init()
    }
}
