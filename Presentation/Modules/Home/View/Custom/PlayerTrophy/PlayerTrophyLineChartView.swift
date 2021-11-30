//
//  PlayerTrophyLineChartView.swift
//  Presentation
//
//  Created by nakandakari on 2020/06/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Algorithms
import Charts
import Domain
import UIKit

protocol DateFilterTabViewDelegate: AnyObject {
    func didTapFilterButton(index: Int)
}

final class PlayerTrophyLineChartView: UIView {

    private let lineAnimateSecPerOne: TimeInterval = 1.0 / 60.0

    private let trophyTitleLabelKey = "trophy_cell_title_key"
    private let noDataTitleLabelKey = "trophy_graph_no_data_title_key"
    private let trophyChangesTitleLabelKey = "trophy_graph_changes_title_key"

    @IBOutlet private weak var trophyTitleLabel: UILabel! {
        willSet {
            newValue.text = self.trophyTitleLabelKey.localized
        }
    }

    @IBOutlet private weak var noDataTitleLabel: UILabel! {
        willSet {
            newValue.text = self.noDataTitleLabelKey.localized
        }
    }

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

    private var battleLogs: [RealmBattleLogModel] = []
    private var trophyDateFilters: [TrophyDateFilter] = []

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
        self.battleLogs = battleLogs
        self.trophyLineChartView.isHidden = false
        self.noDataView.isHidden = true

        let entry = createEntries(realmBattleLogModels: battleLogs)
        let dataSet = self.createDataSet(entry: entry)
        let chartData = LineChartData(dataSet: dataSet)
        self.trophyLineChartView.data = chartData
        self.trophyLineChartView.animate(xAxisDuration: self.lineAnimateSecPerOne * TimeInterval(battleLogs.count))
    }

    func setupDateFilterTabView(trophyDateFilters: [TrophyDateFilter], initialIndex: Int = 0) {
        self.trophyDateFilters = trophyDateFilters
        let tabTexts = self.trophyDateFilters.map { $0.tabTitle }
        self.dateFilterTabView.setupTab(tabTexts: tabTexts, initialIndex: initialIndex)
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
        let dataSet = LineChartDataSet(entries: entry, label: self.trophyChangesTitleLabelKey.localized)

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

        // TODO: 消しても良さそう
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

// MARK: - Refresh text
extension PlayerTrophyLineChartView {

    func refreshText() {
        self.trophyTitleLabel.text    = self.trophyTitleLabelKey.localized
        self.noDataTitleLabel.text    = self.noDataTitleLabelKey.localized
        self.trophyLineChartView.data = self.recreateLineChartData()
        self.dateFilterTabView.refreshText(tabTexts: self.trophyDateFilters.map { $0.tabTitle })
    }

    private func recreateLineChartData() -> LineChartData {
        let entry = createEntries(realmBattleLogModels: self.battleLogs)
        let dataSet = self.createDataSet(entry: entry)
        let chartData = LineChartData(dataSet: dataSet)
        return chartData
    }
}

private extension TrophyDateFilter {

    var tabTitle: String {
        switch self {
        case .today   : return "trophy_graph_tab_today_title_key".localized
        case .weekly  : return "trophy_graph_tab_week_title_key".localized
        case .monthly : return "trophy_graph_tab_month_title_key".localized
        case .year    : return "trophy_graph_tab_year_title_key".localized
        }
    }
}
