//
//  AlertModel.swift
//  ICounted
//
//  Created by Nebo on 13.10.2024.
//

import Foundation

enum AlertType: String {
    case success = "Success", error = "Error", warning = "Warning"
}

struct AlertAction: Identifiable {
    let id: UUID = UUID()
    let name: String
    let completion: () -> Void
}

struct AlertModel {
    let type: AlertType
    let title: String
    let message: String
    let actions: [AlertAction]
    
    static func getErrorModel(message: String) -> AlertModel {
        AlertModel(type: .error, title: "", message: message, actions: [.init(name: "OK", completion: {})])
    }
    
    static func getSuccessModel(message: String) -> AlertModel {
        AlertModel(type: .success, title: "", message: message, actions: [.init(name: "OK", completion: {})])
    }
}
