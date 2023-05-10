//
//  LegacyBaseViewController.swift
//  BindableBase
//
//  Created by Mason on 2023/05/10.
//

import UIKit
import RxSwift

class LegacyBaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // 공통 UI 처리
    func configureUI() { }
    
    // 공통 Error 처리
    // 2.
    func handleSignal<ViewModel: BaseViewModel>(_ viewModel: ViewModel) -> ViewModel {
        viewModel.signal
            .subscribe(onNext: { [weak self] in
                self?.handleSignal($0)
            }).disposed(by: disposeBag)
        
        return viewModel
    }
    
    // Child VC의 공통 Error 처리
    // 3.
    func handleSignal(_ signal: BaseSignal) {
        guard let errorSignal = signal as? ErrorSignal else { return }
        
        switch errorSignal {
        case .api:
            print("handle api error")
        case .network:
            print("handle network error")
        }
    }
    
    // Reactor View의 Error처리
    // 4.
    func handleError(_ error: Error) {
        switch error {
        case let error as NetworkError:
            handleNetworkError(error)
        case let error as APIError:
            handleAPIError(error)
        default:
            break
        }
    }
    
    private func handleNetworkError(_ error: NetworkError) { }
    private func handleAPIError(_ error: APIError) { }
}
