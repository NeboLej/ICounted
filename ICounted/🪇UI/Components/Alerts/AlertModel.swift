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
        case .error: Localized.shared.alert.errorTitle
        case .success: Localized.shared.alert.successTitle
        case .warning: Localized.shared.alert.warningTitle
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
        AlertModel(type: .error, title: "", message: message, actions: [.init(name: Localized.shared.alert.okButton, completion: {})])
    }
    
    static func getSuccessModel(message: String) -> AlertModel {
        AlertModel(type: .success, title: "", message: message, actions: [.init(name: Localized.shared.alert.okButton, completion: {})])
    }
}

extension AlertModel: Equatable {
    static func == (lhs: AlertModel, rhs: AlertModel) -> Bool {
        lhs.type == rhs.type &&
        lhs.title == rhs.title &&
        lhs.message == rhs.message
    }
}
