//
//  TabBarView.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/16.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

protocol TabBarViewDelegate: AnyObject {
    func didTapTabBarButton(index: Int)
}

final class TabBarView: UIView {

    @IBOutlet private weak var selectedView: UIView!
    @IBOutlet private weak var selectedViewLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!

    private var tabBarButtonViews: [TabBarButtonView] = []
    private var selectedTabIndex: Int = 0
    private var tabTexts: [String] = []

    weak var delegate: TabBarViewDelegate?

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
extension TabBarView {

    func setupTab(tabTexts: [String], initialIndex: Int = 0, fontSize: CGFloat = TabBarButtonView.DefaultFontSize) {
        self.tabTexts = tabTexts
        self.selectedTabIndex = initialIndex
        self.removeAllTabBarButtonViews()
        self.addTabBarButtonViews(texts: tabTexts, fontSize: fontSize)
        self.setupStackView(fontSize: fontSize)
        self.moveSelectedView(index: self.selectedTabIndex, moveDuration: 0)
    }

    // Remove button view from StackView and Array
    private func removeAllTabBarButtonViews() {
        self.tabBarButtonViews.forEach {
            self.stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        self.tabBarButtonViews.removeAll()
    }

    // Create button view and add StackView
    private func addTabBarButtonViews(texts: [String], fontSize: CGFloat) {
        for (index, text) in texts.enumerated() {
            let tabBarButtonView = self.createTabBarButtonView(text: text, index: index, fontSize: fontSize)
            self.stackView.addArrangedSubview(tabBarButtonView)
            self.tabBarButtonViews.append(tabBarButtonView)
        }
    }

    private func setupStackView(fontSize: CGFloat) {
        self.stackView.isHidden = false
        self.stackView.layoutIfNeeded() // want to get child view frame
        let stackViewSize = self.stackView.frame.size
        self.selectedView.frame.size = CGSize(width: stackViewSize.width / CGFloat(self.tabBarButtonViews.count), height: stackViewSize.height)
        self.selectedViewLabel.frame.size = self.selectedView.frame.size
        self.selectedViewLabel.font = UIFont.HiraginoSansW7(size: fontSize)
    }

    private func createTabBarButtonView(text: String, index: Int, fontSize: CGFloat) -> TabBarButtonView {
        let tabBarButtonView = TabBarButtonView()
        tabBarButtonView.delegate = self
        tabBarButtonView.setup(text: text, index: index, fontSize: fontSize)
        return tabBarButtonView
    }
}

// MARK: - SelectedView
extension TabBarView {

    func moveSelectedView(index: Int, moveDuration: TimeInterval = 0.2) {
        if self.stackView.subviews.count <= index {
            return
        }

        let targetView = self.stackView.subviews[index]
        let moveTargetPosition = targetView.frame.origin

        self.selectedViewLabel.text = ""

        UIView.animate(withDuration: moveDuration, animations: {
            self.selectedView.frame.origin.x = moveTargetPosition.x
        }, completion: { _ in
            self.selectedViewLabel.text = self.tabTexts[index]
            // Control tabBarButton borderLine show/hide
            self.showAllBorderLine()
            self.hideBorderLine(indices: [index - 1, index])
            self.hideText(index: index)
        })
    }
}

// MARK: - TabBarButtonViewDelegate
extension TabBarView: TabBarButtonViewDelegate {

    func didTapButton(index: Int) {
        self.showText(index: self.selectedTabIndex)
        self.selectedTabIndex = index
        self.moveSelectedView(index: index)
        SoundManager.shared.playSoundEffect(.selectTab)
        self.delegate?.didTapTabBarButton(index: index)
    }

}

// MARK: - Text, BorderLine Show/Hide
private extension TabBarView {

    func showAllBorderLine() {
        self.tabBarButtonViews.forEach { $0.showBorderLine() }
    }

    func hideBorderLine(indices: [Int]) {
        indices.forEach { self.hideBorderLine(index: $0) }
    }

    func hideBorderLine(index: Int) {
        if index < 0 || self.tabBarButtonViews.count <= index {
            return
        }
        self.tabBarButtonViews[index].hideBorderLine()
    }

    func showText(index: Int) {
        if index < 0 || self.tabBarButtonViews.count <= index {
            return
        }
        self.tabBarButtonViews[index].showText()
    }

    func hideText(index: Int) {
        if index < 0 || self.tabBarButtonViews.count <= index {
            return
        }
        self.tabBarButtonViews[index].hideText()
    }
}

// MARK: - Refresh text
extension TabBarView {

    func refreshText(tabTexts: [String]) {
        self.tabTexts = tabTexts

        // ボタンそれぞれのテキストを変更
        for (index, text) in self.tabTexts.enumerated() {
            self.tabBarButtonViews[index].refreshButtonText(text)
        }

        // ボタンの上に載せているテキストを変更
        self.selectedViewLabel.text = self.tabTexts[self.selectedTabIndex]
    }
}
