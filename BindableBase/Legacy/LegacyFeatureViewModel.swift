//
//  FeatureViewModel.swift
//  BindableBase
//
//  Created by Mason on 2023/05/10.
//

import Foundation
import RxSwift

class LegacyFeatureViewModel: BaseViewModel {
    
    enum Signal: BaseSignal {
        case didComplete
    }

    // MARK: Output
    let text: Observable<String>
    private let _text = PublishSubject<String>()
    
    override init() {
        text = _text.asObservable()
        
        super.init()
    }
    
    func fetchText() {
        _text.onNext("Result")
        
        // if Error Occurred
        _signal.onNext(ErrorSignal.api)
    }
    
    func executeSomeWork() {
        _signal.onNext(Signal.didComplete)
    }
}
