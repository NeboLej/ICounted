//
//  AppStore.swift
//  ICounted
//
//  Created by Nebo on 07.07.2024.
//

import Foundation

final class AppStore: ObservableObject {
     @Published private(set) var state: AppState
     
    init(state: AppState = TEST.state) {
         self.state = state
     }
     
     public func dispatch(action: AppAction) {
         state = reducer(state: state, action: action)
     }
 }



var TEST: AppStore = AppStore(state: AppState(counters: [
    Counter(name: "Smoked some cigarettes ",
            description: "how much have I smoked since winter sad sds da d dsfds fsd fsd fs fs f dsabsmndb as dabs djhbasf wf we fewf  qwdwqd qdzd as jsnkadjnakj ndkajsnd kaskd absdan dkjasn dkanskd jnak",
            count: 20,
            lastRecord: Date(),
            colorHex: "04a6d9",
            isFavorite: true,
            taggetCount: nil),
    
    Counter(name: "Walking the dog",
            description: "",
            count: 104,
            lastRecord: Date(),
            colorHex: "ea9171",
            isFavorite: false,
            taggetCount: 180),
    
    Counter(name: "Jog in the mornings",
            description: "run 30 times and evaluate the result",
            count: 777,
            lastRecord: Date(),
            colorHex: "043464",
            isFavorite: true,
            taggetCount: nil),
    
]))
