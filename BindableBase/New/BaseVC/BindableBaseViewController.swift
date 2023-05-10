//
//  BindableBaseViewController.swift
//  BindableBase
//
//  Created by Mason on 2023/05/10.
//

import UIKit
import RxSwift
import RxCocoa

protocol ViewModelBindable {
    associatedtype ViewModel: BaseViewModel
    var viewModel: ViewModel { get set }
    var disposeBag: DisposeBag { get set }
    func bindInput()
    func bindOutput()
    func handleSignal()
}

class BindableBaseViewController<ViewModel: BaseViewModel>: BaseViewController,ViewModelBindable {
    
    var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindOutput()
        bindInput()
        handleSignal()
    }
    
    // MARK: Binding
    
    func bindInput() { }
    
    func bindOutput() { }
    
    func handleSignal() {
        // 공통 Error Binding
        viewModel.signal
            .compactMap { $0 as? ErrorSignal }
            .subscribe(onNext: {
                switch $0 {
                case .api:
                    print("handle api error")
                case .network:
                    print("handle network error")
                }
            }).disposed(by: disposeBag)
    }
}
