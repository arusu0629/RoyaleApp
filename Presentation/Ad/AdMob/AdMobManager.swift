//
//  AdMobManager.swift
//  Analytics
//
//  Created by nakandakari on 2020/10/01.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import GoogleMobileAds
import UIKit

final class AdMobManager: NSObject, AdManagerProtocol {

    weak var delegate: AdReceiverDelegate?
    private var bannerView: GADBannerView!
}

extension AdMobManager {

    func setupBannerView(vc: UIViewController, adView: UIView, id: String) {
        self.bannerView = GADBannerView(frame: adView.frame)
        self.bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.bannerView.rootViewController = vc
        self.bannerView.adUnitID = id
        self.bannerView.delegate = self
        self.bannerView.load(GADRequest())
        adView.addSubview(self.bannerView)
        adView.fitToSelf(childView: self.bannerView)
    }
}

extension AdMobManager: GADBannerViewDelegate {

    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        self.delegate?.didReceiveAd()
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        self.delegate?.didFailedAd()
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
