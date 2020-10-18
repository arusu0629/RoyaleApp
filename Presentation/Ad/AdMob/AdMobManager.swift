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
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        self.adDelegate?.didReceiveAd()
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        self.adDelegate?.didFailedAd()
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

// MARK: - MovieReward
extension AdMobManager {

    func setupMovieReward(vc: UIViewController, id: String) {
        self.hasRequestMovieCancel = false
        self.rewardedAd = GADRewardedAd(adUnitID: id)
        if self.rewardedAd.isReady {
            self.rewardedAd.present(fromRootViewController: vc, delegate: self)
            return
        }
        self.rewardedAd.load(GADRequest()) { error in
            if self.hasRequestMovieCancel {
                return
            }
            if let error = error {
                self.movieRewardDelegate?.didFailedMovieReward(error: error)
            } else {
                self.rewardedAd.present(fromRootViewController: vc, delegate: self)
            }
        }
    }

    func requestCancelMovieReward() {
        self.hasRequestMovieCancel = true
    }
}

extension AdMobManager: GADRewardedAdDelegate {

    /// Tells the delegate that the user earned a reward.
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        self.userDidEarn = true
    }
    /// Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        self.movieRewardDelegate?.didPresentMovieReward()
        self.userDidEarn = false
    }
    /// Tells the delegate that the rewarded ad was dismissed.
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        if self.userDidEarn {
            self.movieRewardDelegate?.didSuccessMovieReward()
        }
    }
    /// Tells the delegate that the rewarded ad failed to present.
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print("Rewarded ad failed to present.")
        self.movieRewardDelegate?.didFailedMovieReward(error: error)
    }
}
