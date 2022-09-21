//
//  AdMobManager.swift
//  Analytics
//
//  Created by nakandakari on 2020/10/01.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import GoogleMobileAds
import UIKit

final class AdMobManager: NSObject, AdManagerProtocol, MovieRewardManagerProtocol {

    weak var adDelegate: AdReceiverDelegate?
    weak var movieRewardDelegate: MovieRewardReceiverDelegate?

    private var bannerView: GADBannerView!
    private var rewardedAd: GADRewardedAd!

    private var userDidEarn: Bool = false
    private var hasRequestMovieCancel: Bool = false
}

// MARK: - Setup
extension AdMobManager {

    static func setup() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
}

// MARK: - Ad
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
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        self.adDelegate?.didReceiveAd()
    }

    /// Tells the delegate an ad request failed.
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        self.adDelegate?.didFailedAd()
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewDidDismissScreen")
    }
}

// MARK: - MovieReward
extension AdMobManager {

    func setupMovieReward(vc: UIViewController, id: String) {
        self.hasRequestMovieCancel = false

        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: id, request: request, completionHandler: { (ad, gadError) in
            if let error = gadError {
                self.movieRewardDelegate?.didFailedMovieReward(error: error)
                return
            }
            if self.hasRequestMovieCancel {
                return
            }
            self.rewardedAd = ad
            self.rewardedAd.fullScreenContentDelegate = self
            self.rewardedAd.present(fromRootViewController: vc, userDidEarnRewardHandler: {
                self.userDidEarn = true
            })
        })
    }

    func requestCancelMovieReward() {
        self.hasRequestMovieCancel = true
    }
}

extension AdMobManager: GADFullScreenContentDelegate {

    /// Tells the delegate that an impression has been recorded for the ad.
    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
        print("adDidRecordImpression")
        self.movieRewardDelegate?.didPresentMovieReward()
        self.userDidEarn = false

    }

    /// Tells the delegate that the rewarded ad was dismissed.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        if self.userDidEarn {
            self.movieRewardDelegate?.didSuccessMovieReward()
        } else {
            self.movieRewardDelegate?.didCancelMovieReward()
        }
    }

    /// Tells the delegate that the rewarded ad failed to present.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("GADFullScreenPresentingAd with error: \(error.localizedDescription).")
    }
}
