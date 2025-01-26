//
//  ICounterWidgetLiveActivity.swift
//  ICounterWidget
//
//  Created by Nebo on 25.01.2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ICounterWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ICounterWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ICounterWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ICounterWidgetAttributes {
    fileprivate static var preview: ICounterWidgetAttributes {
        ICounterWidgetAttributes(name: "World")
    }
}

extension ICounterWidgetAttributes.ContentState {
    fileprivate static var smiley: ICounterWidgetAttributes.ContentState {
        ICounterWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ICounterWidgetAttributes.ContentState {
         ICounterWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ICounterWidgetAttributes.preview) {
   ICounterWidgetLiveActivity()
} contentStates: {
    ICounterWidgetAttributes.ContentState.smiley
    ICounterWidgetAttributes.ContentState.starEyes
}
