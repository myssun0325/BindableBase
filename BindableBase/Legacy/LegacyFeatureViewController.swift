//
//  LegacyFeatureViewController.swift
//  BindableBase
//
//  Created by Mason on 2023/05/10.
//

import UIKit
import RxSwift
import RxCocoa

class LegacyFeatureViewController: LegacyBaseViewController {
    
    private let textLabel = UILabel()
    
    // 공통 Error 처리
    // 1.
    private lazy var viewModel = handleSignal(LegacyFeatureViewModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        // 뷰모델 메서드를 직접 호출
        // 5.
        viewModel.fetchText()
    }
    
    private func bindViewModel() {
        viewModel.text
            .bind(to: textLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.signal
            .compactMap { $0 as? LegacyFeatureViewModel.Signal }
            .subscribe(onNext: {
                switch $0 {
                case .didComplete:
                    print("didComplete")
                }
            }).disposed(by: disposeBag)
    }
    
}
