//
//  SettingsScreenStore.swift
//  ICounted
//
//  Created by Nebo on 08.02.2025.
//

import UIKit

@Observable
class SettingsScreenStore {
    
    var alert: AlertModel?
    
    func openSendProblemScreen() {
        openMail(emailTo: "antrabot@gmail.com", subject: Localized.shared.settings.sendFeedbackEmailTheme, body: "")
    }
    
    private func openMail(emailTo:String, subject: String, body: String) {
        if let url = URL(string: "mailto:\(emailTo)?subject=\(subject)&body=\(body)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openAppStore() {
        let appID = Bundle.main.object(forInfoDictionaryKey: "AppID") as? String ?? ""
        let urlStr = "itms-apps://itunes.apple.com/app/id\(appID)"
        
        if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            alert = AlertModel(type: .warning, title: "Попробуйте позже", message: "Пока приоложения нет в магазине, как только оно появится его можно будет оценить", actions: [.init(name: "ок", completion: { [weak self] in self?.alert = nil } )])
        }
    }
    
    func openDonation() {
        alert = AlertModel(type: .success, title: "Похвалить", message: "Можешь написать разрабу что понравилось, предложить свою идею. Думаю, ему будет приятно.", actions: [.init(name: "ок", completion: { [weak self] in self?.alert = nil } )])
    }
}
