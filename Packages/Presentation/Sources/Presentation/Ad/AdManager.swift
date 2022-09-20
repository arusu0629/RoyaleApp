//
//  AdManager.swift
//  Analytics
//
//  Created by nakandakari on 2020/10/01.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation
import UIKit

public protocol AdManagerDataSource: AnyObject {
    func currentViewController() -> UIViewController
}

public protocol AdManagerDelegate: AnyObject {
    func didReceiveAd()
    func didFailedAd()
}

protocol AdManagerProtocol: AnyObject {
    var adDelegate: AdReceiverDelegate? { get set }
}

protocol AdReceiverDelegate: AnyObject {
    func didReceiveAd()
    func didFailedAd()
}

public final class AdManager {

    static let shared = AdManager()

    private init() {}

    public static func setup() {
        AdMobManager.setup()
    }

    weak var delegate: AdManagerDelegate?
    weak var dataSource: AdManagerDataSource?

    private var adMobManager: AdMobManager?
}

extension AdManager {

    public func setupAd(dataSource: AdManagerDataSource, delegate: AdManagerDelegate, targetView: UIView) {
        guard let adNetwork = AdNetwork.all().first else {
            // TODO: Clean 処理
            return
        }
        self.dataSource = dataSource
        self.delegate = delegate
        self.setupAdView(adNetwork: adNetwork, targetView: targetView)
    }

    private func setupAdView(adNetwork: AdNetwork, targetView: UIView) {
        guard let vc = self.dataSource?.currentViewController() else {
            return
        }
        switch adNetwork {
        case .admob(let id):
            self.adMobManager = AdMobManager()
            self.adMobManager?.adDelegate = self
            self.adMobManager?.setupBannerView(vc: vc, adView: targetView, id: id)
        }
    }
}

extension AdManager: AdReceiverDelegate {

    func didReceiveAd() {
        self.delegate?.didReceiveAd()
    }

    func didFailedAd() {
        // TODO: AdNetwork 増やしたら次の広告を読み込み処理を追加する
        self.delegate?.didFailedAd()
    }
}
