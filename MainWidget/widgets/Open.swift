//
//  Open.swift
//  OCW
//
//  Created by 朵朵 on 2021/8/19.
//
import SwiftUI
import WidgetKit
import Intents

struct OpenProvider: TimelineProvider {
    func placeholder(in context: Context) -> OpenEntry {
        OpenEntry(date: Date())
    
    }

    func getSnapshot(in context: Context, completion: @escaping (OpenEntry) -> ()) {
        let entry = OpenEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [OpenEntry] = []


        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = OpenEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct OpenEntry: TimelineEntry {
    public let date: Date
}
//小型组件只支持widgetURL 不支持Link
struct OpenEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: OpenProvider.Entry
    
    @ViewBuilder
    var body: some View {
        OpenView().widgetURL(URL(string: "https://sixming.com"))
    }
    
}
struct OpenPlaceholderView : View {
    //这里是PlaceholderView - 提醒用户选择部件功能
    var body: some View {
        OpenView()
    }
}


struct OpenWidget: Widget {
    let kind: String = "OpenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: OpenProvider()) { entry in
            OpenEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget 666")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}
