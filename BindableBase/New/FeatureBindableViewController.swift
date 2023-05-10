//
//  FeatureBindableViewController.swift
//  BindableBase
//
//  Created by Mason on 2023/05/10.
//

import UIKit
import RxSwift
import RxCocoa

class FeatureBindableViewController: BindableBaseViewController<NewFeatureViewModel> {
    
    // MARK: - View
    private let textLabel = UILabel()
    
    // MARK: - Configure UI
    override func configureUI() {
        super.configureUI()
    }
    
    // MARK: - Bind Input
    override func bindInput() {
        super.bindInput()
        
        UIButton().rx.tap
            .bind(to: viewModel.input.fetch)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Bind Output
    override func bindOutput() {
        super.bindOutput()
        
        viewModel.output.text
            .bind(to: textLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: ViewModel의 Signal이 필요한 경우 사용
    override func handleSignal() {
        super.handleSignal() // 커스텀 처리를 하기위해선 호출할 필요가 없음.
        
        // Handle Custom Signal
        viewModel.signal
            .compactMap { $0 as? NewFeatureViewModel.Signal }
            .subscribe(onNext: { _ in
            }).disposed(by: disposeBag)
    }
}
