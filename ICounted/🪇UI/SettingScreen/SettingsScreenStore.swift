//
//  SettingsScreenStore.swift
//  ICounted
//
//  Created by Nebo on 08.02.2025.
//

import UIKit

@Observable
class SettingsScreenStore {
    
    func openSendProblemScreen() {
        openMail(emailTo: "antrabot@gmail.com", subject: Localized.shared.settings.sendFeedbackEmailTheme, body: "")
    }
    
    private func openMail(emailTo:String, subject: String, body: String) {
        if let url = URL(string: "mailto:\(emailTo)?subject=\(subject)&body=\(body)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
