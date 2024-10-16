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
            lastRecord: nil,
            colorHex: "04a6d9",
            isFavorite: true,
            targetCount: nil),
    
    Counter(name: "Walking the dog",
            description: "",
            count: 104,
            lastRecord: Date(),
            colorHex: "ea9171",
            isFavorite: false,
            targetCount: 180),
    
    Counter(name: "Jog in the mornings",
            description: "run 30 times and evaluate the result",
            count: 777,
            lastRecord: nil,
            colorHex: "043464",
            isFavorite: true,
            targetCount: nil),
    
    Counter(name: "Eat some pies",
            description: "eat 100 pies to become very big and prove to everyone that I am a big person",
            count: 5,
            lastRecord: Date(),
            colorHex: "ec5c8c",
            isFavorite: true,
            targetCount: 100),
    
    Counter(name: "Headache",
            description: "how many times did you have a headache. Need statistics",
            count: 11,
            lastRecord: Date(),
            colorHex: "74ab63",
            isFavorite: true,
            targetCount: nil),
    
]))
