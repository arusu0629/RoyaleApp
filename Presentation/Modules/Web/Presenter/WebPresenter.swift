//
//  WebPresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 02/10/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Analytics
import Domain
import Foundation

protocol WebPresenter: AnyObject {
    func viewDidLoad()

    // WebView
    func didStartProvisionalNavigation()
    func didFinish()

    func didSelectBack()
    func didSelectForward()
    func didSelectReload()
    func didSelectWebViewTab(index: Int)
}

final class WebPresenterImpl: WebPresenter {

    weak var view: WebView?
    var wireframe: WebWireframe!

    var webViewTabUseCase: WebViewTabUseCase!

    private var selectedWebViewTabIndex: Int = 0

    init() {
        self.selectedWebViewTabIndex = AppConfig.lastSelectedWebViewTabIndex
    }

    func viewDidLoad() {
        AnalyticsManager.sendEvent(WebEvent.display)
        //        self.view?.showFooterAdView()
        self.view?.hideFooterAdView()
        self.setupWebView()
    }

    func didStartProvisionalNavigation() {
        self.view?.showLoading()
    }

    func didFinish() {
        self.view?.hideLoading()
    }

    private func setupWebView() {
        self.view?.setupWebView()
        self.view?.setupWebViewTab(self.webViewTabUseCase.list(), initialIndex: self.selectedWebViewTabIndex)

        let lastSelectedWebViewTab = self.webViewTabUseCase.list()[AppConfig.lastSelectedWebViewTabIndex]
        guard let url = URL(string: lastSelectedWebViewTab.urlString) else {
            self.view?.showErrorAlert(WebViewError.invalidURL(url: lastSelectedWebViewTab.urlString))
            return
        }
        self.view?.loadRequest(URLRequest(url: url))
    }

    func didSelectBack() {
        self.view?.pageBack()
    }

    func didSelectForward() {
        self.view?.pageForward()
    }

    func didSelectReload() {
        self.view?.pageReload()
    }

    func didSelectWebViewTab(index: Int) {
        let selectedWebViewTab = self.webViewTabUseCase.list()[index]
        guard let url = URL(string: selectedWebViewTab.urlString) else {
            self.view?.showErrorAlert(WebViewError.invalidURL(url: selectedWebViewTab.urlString))
            return
        }
        AnalyticsManager.sendEvent(WebEvent.selectWebTab(tab: selectedWebViewTab))
        self.view?.loadRequest(URLRequest(url: url))
        AppConfig.lastSelectedWebViewTabIndex = index
    }
}

private extension WebViewTab {

    var urlString: String {
        switch self {
        case .classicChallenge:
            return FirebaseRemoteConfigManager.getClassicChallengeWebViewUrl()
        case .grandChallenge:
            return FirebaseRemoteConfigManager.getGrandChallengeWebViewUrl()
        case .topLadder:
            return FirebaseRemoteConfigManager.getTopLadderWebViewUrl()
        }
    }
}
