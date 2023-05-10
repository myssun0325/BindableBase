//
//  BaseViewModel.swift
//  BindableBase
//
//  Created by Mason on 2023/05/10.
//

import Foundation
import RxSwift
import RxRelay

protocol BaseSignal { }

enum ErrorSignal: BaseSignal {
    case network
    case api
}

class BaseViewModel {
    let disposeBag = DisposeBag()
    
    let signal: Observable<BaseSignal>
    let _signal = PublishSubject<BaseSignal>()
    
    init() {
        signal = _signal.asObservable()
    }
}
