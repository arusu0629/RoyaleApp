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
    @IBOutlet private weak var stackView: UIStackView!

    private var tabBarButtonViews: [TabBarButtonView] = []
    private var selectedTabIndex: Int = 0

    weak var delegate: TabBarButtonViewDelegate?

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

    func setupTab(tabTexts: [String], initialIndex: Int = 0) {
        self.selectedTabIndex = initialIndex
        self.removeAllTabBarButtonViews()
        self.addTabBarButtonViews(texts: tabTexts)
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
    private func addTabBarButtonViews(texts: [String]) {
        for (index, text) in texts.enumerated() {
            let tabBarButtonView = self.createTabBarButtonView(text: text, index: index)
            self.stackView.addArrangedSubview(tabBarButtonView)
            self.tabBarButtonViews.append(tabBarButtonView)
        }
        self.stackView.isHidden = false
        self.stackView.layoutIfNeeded() // want to get child view frame
        self.moveSelectedView(index: self.selectedTabIndex, moveDuration: 0)
    }

    private func createTabBarButtonView(text: String, index: Int) -> TabBarButtonView {
        let tabBarButtonView = TabBarButtonView()
        tabBarButtonView.delegate = self
        tabBarButtonView.setup(text: text, index: index)
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

        UIView.animate(withDuration: moveDuration) {
            self.selectedView.frame.origin.x = moveTargetPosition.x
        }
    }
}

// MARK: - TabBarButtonViewDelegate
extension TabBarView: TabBarButtonViewDelegate {

    func didTapButton(index: Int) {
        self.moveSelectedView(index: index)
        self.delegate?.didTapButton(index: index)
    }
}
