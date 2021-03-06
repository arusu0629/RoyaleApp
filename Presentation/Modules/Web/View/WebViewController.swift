//
//  WebViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 02/10/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit
import WebKit

protocol WebView: ShowErrorAlertView {
    func setupWebView()
    func setupWebViewTab(_ tabs: [WebViewTab], initialIndex: Int)
    func loadRequest(_ request: URLRequest)

    func showLoading()
    func hideLoading()

    func pageBack()
    func pageForward()
    func pageReload()

    // Ad
    func showFooterAdView()
    func hideFooterAdView()
}

// MARK: - Properties
final class WebViewController: UIViewController {

    // TabBar
    @IBOutlet private weak var webViewTabBarView: TabBarView! {
        willSet {
            newValue.delegate = self
        }
    }

    // Content
    @IBOutlet private weak var contentView: UIView!

    // ToolButton
    @IBOutlet private weak var backButton: UIButton! {
        willSet {
            newValue.setImage(SFSymbols.arrowLeftIconImage, for: .normal)
        }
    }
    @IBOutlet private weak var forwardutton: UIButton! {
        willSet {
            newValue.setImage(SFSymbols.arrowRightIconImage, for: .normal)
        }
    }
    @IBOutlet private weak var reloadButton: UIButton! {
        willSet {
            newValue.setImage(SFSymbols.arrowReloadIconImage, for: .normal)
        }
    }

    // SpacerView
    @IBOutlet private weak var footerSpacerView: UIView!

    // Ad
    @IBOutlet private weak var footerAdView: FooterAdView!

    // Indicator
    @IBOutlet private weak var indicator: UIActivityIndicatorView!

    var presenter: WebPresenter!

    private var webView: WKWebView! {
        didSet {
            self.webView.navigationDelegate = self
            self.webView.allowsBackForwardNavigationGestures = true
        }
    }
}

// MARK: - Life cycle
extension WebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
}

// MARK: - WebView
extension WebViewController: WebView {

    func setupWebView() {
        self.webView = WKWebView()
        self.contentView.addSubview(self.webView)
        self.contentView.fitToSelf(childView: self.webView)
        self.setupToolButton()
    }

    func setupWebViewTab(_ tabs: [WebViewTab], initialIndex: Int) {
        self.webViewTabBarView.setupTab(tabTexts: tabs.map { $0.label }, initialIndex: initialIndex, fontSize: 14)
    }

    func loadRequest(_ request: URLRequest) {
        self.webView.load(request)
    }

    func showLoading() {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }

    func hideLoading() {
        self.indicator.stopAnimating()
        self.indicator.isHidden = true
    }

    func pageBack() {
        _ = self.webView.goBack()
    }

    func pageForward() {
        _ = self.webView.goForward()
    }

    func pageReload() {
        _ = self.webView.reload()
    }

    // Ad
    func showFooterAdView() {
        self.footerAdView.showLoading()
        AdManager.shared.setupAd(dataSource: self, delegate: self, targetView: self.footerAdView)
    }

    func hideFooterAdView() {
        self.footerAdView.isHidden = true
        self.footerSpacerView.isHidden = false
    }
}

// MARK: - ToolButton
extension WebViewController {

    private func setupToolButton() {
        self.backButton.isEnabled = self.webView.canGoBack
        self.forwardutton.isEnabled = self.webView.canGoForward
    }
}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.setupToolButton()
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.presenter.didStartProvisionalNavigation()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.presenter.didFinish()
    }
}

// MARK: - AdManagerDataSource
extension WebViewController: AdManagerDataSource {

    func currentViewController() -> UIViewController {
        return self
    }
}

// MARK: - AdManagerDelegate
extension WebViewController: AdManagerDelegate {

    func didReceiveAd() {
        self.footerAdView.hideLoading()
        self.footerAdView.isHidden = false
        self.footerSpacerView.isHidden = true
    }

    func didFailedAd() {
        self.footerAdView.hideLoading()
        self.hideFooterAdView()
        self.footerSpacerView.isHidden = false
    }
}

// MARK: - UserInteraction
extension WebViewController {

    @IBAction private func didTapBackButton() {
        self.presenter.didSelectBack()
    }

    @IBAction private func didTapForwardButton() {
        self.presenter.didSelectForward()
    }

    @IBAction private func didTapReloadButton() {
        self.presenter.didSelectReload()
    }

}

// MARK: - TabBarView
extension WebViewController: TabBarViewDelegate {

    func didTapTabBarButton(index: Int) {
        self.presenter.didSelectWebViewTab(index: index)
    }
}
