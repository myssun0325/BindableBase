//
//  FeatureReactorViewController.swift
//  BindableBase
//
//  Created by Mason on 2023/05/10.
//

import UIKit
import ReactorKit

final class FeatureReactorViewController: BaseViewController, View {
    
    private let textLabel = UILabel()
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: FeatureViewReactor) {
        // MARK: - State
        reactor.state
            .map(\.text)
            .distinctUntilChanged()
            .bind(to: textLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$error)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] error in
                self?.handleError(error)
            }).disposed(by: disposeBag)
        
        // MARK: - Action
        UIButton().rx.tap
            .map { _ in .fetch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // If you want to customize error handling, override this method.
    //override func handleError(_ error: Error) { }
}
