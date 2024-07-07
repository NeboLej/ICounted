//
//  AppStore.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import Foundation

final class AppStore: ObservableObject {
     @Published private(set) var state: AppState
     
     init(state: AppState = AppState() ) {
         self.state = state
     }
     
     public func dispatch(action: AppAction) {
         state = reducer(state: state, action: action)
     }
 }
