//
//  TodaysTrophyGraphWidget.swift
//  TodaysTrophyGraphWidget
//
//  Created by nakandakari on 2020/12/09.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {

    public typealias Entry = SimpleEntry

    private let todaysResultUseCase = TodaysResultUseCaseProvider.provide()

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), todaysResult: TodaysResultWidgetInfo.dummyData())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let date = Date()
        let todaysResult: TodaysResultWidgetInfo
        if context.isPreview {
            todaysResult = TodaysResultWidgetInfo.dummyData()
            let entry = SimpleEntry(date: date, todaysResult: todaysResult)
            completion(entry)
        } else {
            self.todaysResultUseCase.get { todaysResult in
                let entry = SimpleEntry(date: date, todaysResult: todaysResult)
                completion(entry)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        self.todaysResultUseCase.get { todaysResult in
            let entry = SimpleEntry(date: Date(), todaysResult: todaysResult)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let todaysResult: TodaysResultWidgetInfo
}

struct TodaysTrophyGraphWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall  : TodaysResultSmallView(todaysResult: entry.todaysResult)
        // TODO: Replace TodaysResultMediumView
        case .systemMedium : TodaysResultSmallView(todaysResult: entry.todaysResult)
        default            : Text("") // Unsupported
        }
    }
}

@main
struct TodaysTrophyGraphWidget: Widget {
    let kind: String = "TodaysTrophyGraphWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TodaysTrophyGraphWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

struct TodaysTrophyGraphWidget_Previews: PreviewProvider {
    static var previews: some View {
        TodaysTrophyGraphWidgetEntryView(entry: SimpleEntry(date: Date(), todaysResult: TodaysResultWidgetInfo.dummyData()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
