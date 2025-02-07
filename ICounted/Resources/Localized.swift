//
//  Localized.swift
//  ICounted
//
//  Created by Nebo on 27.01.2025.
//

import Foundation

enum LocalType: CaseIterable, Hashable {
    case russian
    case english
    
    func getLanguage() -> String {
        switch self {
        case .russian: "Русский"
        case .english: "English"
        }
    }
    
    func getLocalChortCode() -> String {
        switch self {
        case .russian: "ru"
        case .english: "en"
        }
    }
}

class LocalizationManager {
    static let shared = LocalizationManager()
    

    private var currentLanguage: String = UserDefaults.standard.get(case: .userLacalize) as? String ?? Locale.current.language.languageCode?.identifier ?? "en" {
        didSet {
            UserDefaults.standard.set(currentLanguage, case: .userLacalize) //standard.set(currentLanguage, forKey: "currentLanguage")
        }
    }
    
    func getCurrentLanguage() -> LocalType {
        switch currentLanguage {
        case "ru":
            return .russian
        default:
            return .english
        }
    }
    
    init() {
        if !LocalType.allCases.map({ $0.getLocalChortCode() }).contains(currentLanguage) {
            currentLanguage = "en"
        }
    }

    func setLanguage(_ language: LocalType) {
        currentLanguage = language.getLocalChortCode()
        Localized.reset()
    }

    func localizedString(forKey key: String) -> String {
        let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return bundle?.localizedString(forKey: key, value: nil, table: nil) ?? key
    }
}

struct Localized {
    
    static var shared = Localized()
    
    let counterListScreen = Localized.CounterListScreen()
    let counterCell = Localized.CounterCell()
    let recordCell = Localized.RecordCell()
    let createCounter = Localized.CreateCounter()
    let counter = Localized.Counter()
    let component = Localized.Component()
    let alert = Localized.Alert()
    let widget = Localized.Widget()
    
    static func reset() {
        Localized.shared = Localized()
    }
    
    static private func localize(_ key: String) -> String {
        return LocalizationManager.shared.localizedString(forKey: key)
    }
    
    struct CounterListScreen {
        let counterPanel = localize("countersList_all_counters_panel")
        let countPanel = localize("countersList_all_count_panel")
        let countPanelDesc = localize("countersList_all_count_panel_desc")
        let settingPanel = localize("counterList_setting_panel")
        let tooltipLongpress = localize("counterList_tooltip_longpress")
    }

    struct CounterCell {
        let addCountButton = localize("counterCell_add_count_button")
        let lastRecord = localize("counterCell_last_record")
    }
    
    struct RecordCell {
        let emptyMessage = localize("record_cell_empty_message")
    }
    
    struct CreateCounter {
        let colorPicker = localize("createCounter_colorPiceker")
        let descriptionTF = localize("createCounter_description_tf")
        let descriptionTFPlaceholder = localize("createCounter_description_tf_placeholder")
        let nameTF = localize("createCounter_name_tf")
        let nameTFPlaceholder = localize("createCounter_name_tf_placeholder")
        let saveButton = localize("createCounter_save_button")
        let startValue = localize("createCounter_start_value")
        let targetValue = localize("createCounter_target_value")
        let title = localize("createCounter_title")
        let toWidget = localize("createCounter_to_widget")
    }
    
    struct Counter {
        let addCountButton = localize("counter_add_count_button")
        let currentValue = localize("counter_current_value")
        let targetValue = localize("counter_target_value")
        let menuDelete = localize("counter_menu_delete")
        let menuEdit = localize("counter_menu_edit")
        func recordsCount(_ count: Int) -> String {
            String(format: localize("counter_records_count"), String(count))
        }
        let toWidget = localize("counter_to_widget")
        func alertDeleteMessage(_ name: String) -> String {
            String(format: localize("counter_delete_alert_message"), name)
        }
        let alertDeleteYesButton = localize("counter_delete_alert_yes")
        let alertDeleteNoButton = localize("counter_delete_alert_no")
        let alertDeleteRecordMessage = localize("counter_delete_record_alert")
        let tooltipLongpress = localize("counter_tooltip_longpress")
    }
    
    struct Component {
        let welcomePageAddCounterButton = localize("component_welcomePage_add_counter_button")
        let welcomePageDescription = localize("component_welcomePage_description")
        let welcomePageTagsArray = localize("component_welcomePage_tags_array")
        
        let messageFormAddCountButton = localize("component_message_form_add_count_button")
        let messageFormMessageTF = localize("component_message_form_message_tf")
        let messageFormMessageTFPlaceholder = localize("component_message_form_message_tf_placeholder")
        let messageFormDate = localize("component_message_form_date")
        
        let dateToday = localize("date_today")
        let dateYesterday = localize("date_yesterday")
        let dateTomorrow = localize("date_tomorrow")
        
        let tooltipOkButton = localize("component_tooltip_ok_button")
    }
    
    struct Alert {
        let errorTitle = localize("alert_error_title")
        let warningTitle = localize("alert_warinig_title")
        let successTitle = localize("alert_success_title")
        let okButton = localize("alert_ok_button")
    }
    
    struct Widget {
        let addCountButton = localize("widget_add_count_button")
        let addCountIntentName = localize("widget_add_count_intent_name")
        let desctiption = localize("widget_description")
        let emptyStateDescription = localize("widget_emptyState_description")
        let name = localize("widget_name")
        
        
        let exapmleName1 = localize("widget_example_name_1")
        let exapmleName2 = localize("widget_example_name_2")
        let exapmleName3 = localize("widget_example_name_3")
        let exapmleName4 = localize("widget_example_name_4")
    }
}
