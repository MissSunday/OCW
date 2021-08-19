//
//  MainWidget.swift
//  MainWidget
//
//  Created by 朵朵 on 2021/8/19.
//

import WidgetKit
import SwiftUI
import Intents


@main
struct Widgets: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
 
        OpenWidget()
        MediumWidget()
    }
}
