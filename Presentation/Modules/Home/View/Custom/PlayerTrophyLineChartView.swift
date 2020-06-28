//
//  PlayerTrophyLineChartView.swift
//  Presentation
//
//  Created by nakandakari on 2020/06/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Charts
import Domain
import UIKit

final class PlayerTrophyLineChartView: UIView {

    @IBOutlet private weak var trophyLineChartView: LineChartView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    private func initialize() {
        self.loadXib()
        self.initializeLineChart()
    }

    private func initializeLineChart() {

        // Whole background color
        self.trophyLineChartView.gridBackgroundColor = .black
        self.trophyLineChartView.drawGridBackgroundEnabled = true

        // Interaction Enabled
        self.trophyLineChartView.pinchZoomEnabled = false
        self.trophyLineChartView.doubleTapToZoomEnabled = false

        // X Axis label
        let xAxis = self.trophyLineChartView.xAxis
        xAxis.labelPosition = .bottom

        // Shwo minimum and maximum only
        xAxis.centerAxisLabelsEnabled = false
        xAxis.setLabelCount(2, force: true)
    }
}

// MARK: - Setup
extension PlayerTrophyLineChartView {

    func setupData(battleLogs: [RealmBattleLogModel]) {
        let entry = createEntries(realmBattleLogModels: battleLogs)
        let dataSet = self.createDataSet(entry: entry)
        let chartData = LineChartData(dataSet: dataSet)
        self.trophyLineChartView.data = chartData
        self.trophyLineChartView.animate(xAxisDuration: 2.0)
    }

    private func createEntries(realmBattleLogModels: [RealmBattleLogModel]) -> [ChartDataEntry] {

        // Define chart xValues formatter
        let xValuesNumberFormatter = PlayerTrophyChartXAxisFormatter(data: realmBattleLogModels)
        self.trophyLineChartView.xAxis.valueFormatter = xValuesNumberFormatter

        var entries: [ChartDataEntry] = []

        for (index, realmBattleLogModel) in realmBattleLogModels.enumerated() {
            let xValue = Double(index)
            let yValue = Double(realmBattleLogModel.afterTrophy)
            let entry = ChartDataEntry(x: xValue, y: yValue)
            entries.append(entry)
        }

        return entries
    }

    private func createDataSet(entry: [ChartDataEntry]) -> LineChartDataSet {
        let dataSet = LineChartDataSet(entries: entry, label: "Trophy Changes")

        // Circle Point
        dataSet.circleRadius = 2.0
        dataSet.circleColors = [.orange]

        // Don't show values
        dataSet.drawValuesEnabled = false

        // Line more smooth
        //        dataSet.mode = .cubicBezier
        //        dataSet.cubicIntensity = 0.2

        // line background color
        dataSet.colors = [.orange]

        return dataSet
    }
}

// MARK: - PlayerTrophyChartXAxisFormatter
final class PlayerTrophyChartXAxisFormatter {
    var dateFormatter = DateFormatter()
    var data: [RealmBattleLogModel]?

    init(data: [RealmBattleLogModel]) {
        self.data = data
        dateFormatter.setTemplate(.date)
    }
}

extension PlayerTrophyChartXAxisFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        guard let data = self.data, index < data.count else {
            return ""
        }
        return dateFormatter.string(from: data[index].battleDate)
    }
}
