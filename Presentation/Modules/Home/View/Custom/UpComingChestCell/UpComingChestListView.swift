//
//  UpComingChestListView.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import UIKit

final class UpComingChestListView: UIView {

    private let upcomingChestTitleLabelKey = "upcoming_chests_cell_title_key"

    @IBOutlet private weak var upcomingChestTitleLabel: UILabel! {
        willSet {
            newValue.text = self.upcomingChestTitleLabelKey.localized
        }
    }
    @IBOutlet private weak var upcomingChestStackView: UIStackView!

    private var chestCells: [UpComingChestCell] = []

    @IBOutlet private weak var indicator: UIActivityIndicatorView! {
        willSet {
            newValue.isHidden = true
        }
    }

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
    }
}

// MARK: - Setup
extension UpComingChestListView {

    func setup(chestsModel: UpComingChestsModel) {
        self.removeAllChestCell()
        for chest in chestsModel.chests {
            let cell = self.createUpComingChestCell(chest: chest)
            self.upcomingChestStackView.addArrangedSubview(cell)
        }
    }
}

// MARK: - UpComingChestCell
extension UpComingChestListView {

    private func createUpComingChestCell(chest: UpComingChestsModel.UpComingChest) -> UpComingChestCell {
        let cell = UpComingChestCell()
        cell.widthAnchor.constraint(equalToConstant: UpComingChestCell.cellSize.width).isActive = true
        cell.heightAnchor.constraint(equalToConstant: UpComingChestCell.cellSize.height).isActive = true
        cell.setupChest(chest)
        self.chestCells.append(cell)
        return cell
    }

    private func removeAllChestCell() {
        for cell in self.chestCells {
            self.upcomingChestStackView.removeArrangedSubview(cell)
            cell.removeFromSuperview()
        }
        self.chestCells.removeAll()
    }
}

// MARK: - Indicator
extension UpComingChestListView {

    func showLoading() {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }

    func hideLoading() {
        self.indicator.isHidden = true
        self.indicator.stopAnimating()
    }
}

// MARK: - Refresh text
extension UpComingChestListView {

    func refreshText() {
        self.upcomingChestTitleLabel.text = self.upcomingChestTitleLabelKey.localized
        self.chestCells.forEach { $0.refreshText() }
    }
}
