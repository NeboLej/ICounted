//
//  Localized.swift
//  ICounted
//
//  Created by Nebo on 27.01.2025.
//

import Foundation

enum Localized {
    enum CounterListScreen {
        static let counterPanel = NSLocalizedString("countersList_all_counters_panel", comment: "")
        static let countPanel = NSLocalizedString("countersList_all_count_panel", comment: "")
        static let countPanelDesc = NSLocalizedString("countersList_all_count_panel_desc", comment: "")
        static let settingPanel = NSLocalizedString("counterList_setting_panel", comment: "")
    }

    enum CounterCell {
        static let addCountButton = NSLocalizedString("counterCell_add_count_button", comment: "")
        static let lastRecord = NSLocalizedString("counterCell_last_record", comment: "")
    }
    
    enum RecordCell {
        static let emptyMessage = NSLocalizedString("record_cell_empty_message", comment: "")
    }
    
    enum CreateCounter {
        static let colorPicker = NSLocalizedString("createCounter_colorPiceker", comment: "")
        static let descriptionTF = NSLocalizedString("createCounter_description_tf", comment: "")
        static let descriptionTFPlaceholder = NSLocalizedString("createCounter_description_tf_placeholder", comment: "")
        static let nameTF = NSLocalizedString("createCounter_name_tf", comment: "")
        static let nameTFPlaceholder = NSLocalizedString("createCounter_name_tf_placeholder", comment: "")
        static let saveButton = NSLocalizedString("createCounter_save_button", comment: "")
        static let startValue = NSLocalizedString("createCounter_start_value", comment: "")
        static let targetValue = NSLocalizedString("createCounter_target_value", comment: "")
        static let title = NSLocalizedString("createCounter_title", comment: "")
        static let toWidget = NSLocalizedString("createCounter_to_widget", comment: "")
    }
    
    enum Counter {
        static let addCountButton = NSLocalizedString("counter_add_count_button", comment: "")
        static let currentValue = NSLocalizedString("counter_current_value", comment: "")
        static let targetValue = NSLocalizedString("counter_target_value", comment: "")
        static let menuDelete = NSLocalizedString("counter_menu_delete", comment: "")
        static let menuEdit = NSLocalizedString("counter_menu_edit", comment: "")
        static func recordsCount(_ count: Int) -> String {
            String(format: NSLocalizedString("counter_records_count", comment: ""), String(count))
        }
        static let toWidget = NSLocalizedString("counter_to_widget", comment: "")
        static func alertDeleteMessage(_ name: String) -> String {
            String(format: NSLocalizedString("counter_delete_alert_message", comment: ""), name)
        }
        static let alertDeleteYesButton = NSLocalizedString("counter_delete_alert_yes", comment: "")
        static let alertDeleteNoButton = NSLocalizedString("counter_delete_alert_no", comment: "")
    }
    
    enum Component {
        static let welcomePageAddCounterButton = NSLocalizedString("component_welcomePage_add_counter_button", comment: "")
        static let welcomePageDescription = NSLocalizedString("component_welcomePage_description", comment: "")
        static let welcomePageTagsArray = NSLocalizedString("component_welcomePage_tags_array", comment: "")
        
        static let messageFormAddCountButton = NSLocalizedString("component_message_form_add_count_button", comment: "")
        static let messageFormMessageTF = NSLocalizedString("component_message_form_message_tf", comment: "")
        static let messageFormMessageTFPlaceholder = NSLocalizedString("component_message_form_message_tf_placeholder", comment: "")
        
        static let dateToday = NSLocalizedString("date_today", comment: "")
        static let dateYesterday = NSLocalizedString("date_yesterday", comment: "")
        static let dateTomorrow = NSLocalizedString("date_tomorrow", comment: "")
    }
    
    enum Alert {
        static let errorTitle = NSLocalizedString("alert_error_title", comment: "")
        static let warningTitle = NSLocalizedString("alert_warinig_title", comment: "")
        static let successTitle = NSLocalizedString("alert_success_title", comment: "")
        static let okButton = NSLocalizedString("alert_ok_button", comment: "")
    }
    
    enum Widget {
        static let addCountButton = NSLocalizedString("widget_add_count_button", comment: "")
        static let addCountIntentName = NSLocalizedString("widget_add_count_intent_name", comment: "")
        static let desctiption = NSLocalizedString("widget_description", comment: "")
        static let emptyStateDescription = NSLocalizedString("widget_emptyState_description", comment: "")
        static let name = NSLocalizedString("widget_name", comment: "")
        
        
        static let exapmleName1 = NSLocalizedString("widget_example_name_1", comment: "")
        static let exapmleName2 = NSLocalizedString("widget_example_name_2", comment: "")
        static let exapmleName3 = NSLocalizedString("widget_example_name_3", comment: "")
        static let exapmleName4 = NSLocalizedString("widget_example_name_4", comment: "")
    }
}
