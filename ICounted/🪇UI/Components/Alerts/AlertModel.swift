//
//  AlertModel.swift
//  ICounted
//
//  Created by Nebo on 13.10.2024.
//

import Foundation

enum AlertType: String {
    case success = "Success", error = "Error", warning = "Warning"
    
    func localizedTitle() -> String {
        switch self {
        case .error: Localized.Alert.errorTitle
        case .success: Localized.Alert.successTitle
        case .warning: Localized.Alert.warningTitle
        }
    }
}

struct AlertAction: Identifiable {
    let id: UUID = UUID()
    let name: String
    var completion: () -> Void
}

struct AlertModel {
    let type: AlertType
    let title: String
    let message: String
    var actions: [AlertAction]
    
    static func getErrorModel(message: String) -> AlertModel {
        AlertModel(type: .error, title: "", message: message, actions: [.init(name: Localized.Alert.okButton, completion: {})])
    }
    
    static func getSuccessModel(message: String) -> AlertModel {
        AlertModel(type: .success, title: "", message: message, actions: [.init(name: Localized.Alert.okButton, completion: {})])
    }
}

extension AlertModel: Equatable {
    static func == (lhs: AlertModel, rhs: AlertModel) -> Bool {
        lhs.type == rhs.type &&
        lhs.title == rhs.title &&
        lhs.message == rhs.message
    }
}
