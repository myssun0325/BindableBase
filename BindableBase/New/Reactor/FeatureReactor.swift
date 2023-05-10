//
//  FeatureReactor.swift
//  BindableBase
//
//  Created by Mason on 2023/05/10.
//

import ReactorKit

enum TestError {
    case test
}

final class FeatureViewReactor: Reactor {
    enum Action {
        case fetch
    }
    
    enum Mutation {
        case setText(String?)
        case setError(Error?)
    }
    
    struct State {
        var text: String?
        @Pulse var error: Error?
    }
    
    var initialState: State
    
    init() {
        initialState = State()
    }
    
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetch:
            return fetchText()
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setText(text):
            state.text = text
        case let .setError(error):
            state.error = error
        }
        
        return state
    }
    
    private func fetchText() -> Observable<Mutation> {
        // If Error occurred.
        //return .just(.setError(.test))
        
        return .just(.setText("Result"))
    }
}
