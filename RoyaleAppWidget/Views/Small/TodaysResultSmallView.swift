//
//  TodaysResultSmallView.swift
//  Analytics
//
//  Created by nakandakari on 2020/12/09.
//

import SwiftUI
import WidgetKit

struct TodaysResultSmallView: View {

    let todaysResult: TodaysResultWidgetInfo

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10, content: {
                Text("Recently Result")

                HStack {
                    LabelAndCountView(label: "Win",  count: self.todaysResult.win)
                    LabelAndCountView(label: "Lose", count: self.todaysResult.lose)
                    LabelAndCountView(label: "Draw", count: self.todaysResult.draw)
                }
                Text("Change \(self.todaysResult.trophyChangesLabel)")
                HStack {
                    Image("player_trophy")
                        .resizable()
                        .frame(width: 28.5, height: 30)
                    Text("\(self.todaysResult.currentTrophy)")
                    Text(Date(), style: .time)
                }
            })
        }
    }
}

struct LabelAndCountView: View {

    let label: String
    let count: Int

    var body: some View {
        VStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            Text(label)
            Text("\(count)")
        })
    }
}

struct TodaysResultSmallView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysResultSmallView(todaysResult: TodaysResultWidgetInfo.dummyData())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
