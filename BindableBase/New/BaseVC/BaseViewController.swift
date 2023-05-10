//
//  BaseViewController.swift
//  BindableBase
//
//  Created by Mason on 2023/05/10.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() { }
    
    func handleError(_ error: Error) {
        // 공통 Error 처리
        switch error {
        case let error as NetworkError:
            print("handle network error: \(error)")
        case let error as APIError:
            print("handle api error: \(error)")
        default:
            break
        }
    }
}
