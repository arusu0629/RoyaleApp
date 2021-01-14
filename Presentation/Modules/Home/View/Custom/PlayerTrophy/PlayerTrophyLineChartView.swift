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

protocol DateFilterTabViewDelegate: AnyObject {
    func didTapFilterButton(index: Int)
}

final class PlayerTrophyLineChartView: UIView {

    @IBOutlet private weak var trophyLineChartView: LineChartView! {
        willSet {
            newValue.isHidden = true
        }
    }

    @IBOutlet private weak var dateFilterTabView: TabBarView! {
        willSet {
            newValue.isHidden = true
            newValue.delegate = self
        }
    }
    @IBOutlet private weak var indicator: UIActivityIndicatorView! {
        willSet {
            newValue.isHidden = true
        }
    }
    @IBOutlet private weak var noDataView: UIView! {
        willSet {
            newValue.isHidden = true
        }
    }

    weak var dateFitlerDelegate: DateFilterTabViewDelegate?

    let lineAnimateSecPerOne: TimeInterval = 1.0 / 60.0

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
        self.trophyLineChartView.isUserInteractionEnabled = false

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

    func setupNoData() {
        self.trophyLineChartView.isHidden = true
        self.noDataView.isHidden = false
    }

    func setupData(battleLogs: [RealmBattleLogModel]) {
        self.trophyLineChartView.isHidden = false
        self.noDataView.isHidden = true

        let entry = createEntries(realmBattleLogModels: battleLogs)
        let dataSet = self.createDataSet(entry: entry)
        let chartData = LineChartData(dataSet: dataSet)
        self.trophyLineChartView.data = chartData
        self.trophyLineChartView.animate(xAxisDuration: self.lineAnimateSecPerOne * TimeInterval(battleLogs.count))
    }

    func setupDateFilterTabView(texts: [String], initialIndex: Int = 0) {
        self.dateFilterTabView.setupTab(tabTexts: texts, initialIndex: initialIndex)
        self.dateFilterTabView.isHidden = false
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

// MARK: - DateFilterTabViewDelegate
extension PlayerTrophyLineChartView: TabBarViewDelegate {

    func didTapTabBarButton(index: Int) {
        self.dateFitlerDelegate?.didTapFilterButton(index: index)
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

extension PlayerTrophyChartXAxisFormatter: AxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        guard let data = self.data, index >= 0, index < data.count else {
            return ""
        }
        return dateFormatter.string(from: data[index].battleDate)
    }
}

// MARK: - Indicator
extension PlayerTrophyLineChartView {

    func showLoading() {

        // show indicator instead of no data text
        self.trophyLineChartView.noDataText = ""

        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }

    func hideLoading() {
        self.indicator.isHidden = true
        self.indicator.stopAnimating()

        if let entryCount = self.trophyLineChartView.data?.entryCount, entryCount <= 0 {
            self.trophyLineChartView.noDataText = "No Data"
        }
    }
}

// MARK: - User Interaction
extension PlayerTrophyLineChartView {

    @IBAction private func didTapLineChartView() {
        // Stop animating
        self.trophyLineChartView.animate(xAxisDuration: 0)
    }
}
