//
//  Medium.swift
//  MainWidgetExtension
//
//  Created by 朵朵 on 2021/8/6.
//

import SwiftUI
import WidgetKit
import Intents

struct MediumProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> MediumEntry {
        MediumEntry(date: Date(),object: Object())
        
    }

    func getSnapshot(in context: Context, completion: @escaping (MediumEntry) -> ()) {
        let entry = MediumEntry(date: Date(),object: Object())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MediumEntry] = []

        //这里进行网络请求 图片加载必须同步请求 缓存成data
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = MediumEntry(date: entryDate,object: Object())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MediumEntry: TimelineEntry {
    public let date: Date
    public let object : Object
    public var imageArray : Array? = Array<UIImage>.init()
    //增加数据模型 传到view层
    //view层只支持简单点逻辑判断  不支持for循环啥的
}

struct Object {
    let url: String = ""
    let description: String = "网络请求的数据"
    var imageObj: UIImage? = UIImage()
}

struct MediumEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: MediumProvider.Entry
    
    @ViewBuilder
    var body: some View {
        MediumView(entry: entry)
    }
    
}
struct MediumPlaceholderView : View {
    //这里是PlaceholderView - 提醒用户选择部件功能
    var body: some View {
        MediumPlaceholder()
    }
}


struct MediumWidget: Widget {
    let kind: String = "MediumWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MediumProvider()) { entry in
            MediumEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget 777")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}


