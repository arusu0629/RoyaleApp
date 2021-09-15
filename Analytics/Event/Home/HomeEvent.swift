//
//  HomeEvent.swift
//  Analytics
//
//  Created by nakandakari on 2020/09/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import Foundation

public enum HomeEvent {
    case display
    case selectDateFilter(trophyDateFilter: TrophyDateFilter)
    case selectPlayMovie
    case selectCancelMovie  // select cancel during loading movie
    case successMovieReward
    case cancelMovieReward  // select cancel during playing movie
    case failedPlayMovie
}

extension HomeEvent: AnalyticsEvent {

    public var name: String {
        switch self {
        case .display:            return "home_display"
        case .selectDateFilter:   return "home_select_trophy_date_filter"
        case .selectPlayMovie:    return "home_select_play_video"
        case .selectCancelMovie:  return "home_select_cancel_video"
        case .successMovieReward: return "home_success_movie_reward"
        case .cancelMovieReward:  return "home_cancel_movie_reward"
        case .failedPlayMovie:    return "home_failed_play_movie"
        }
    }

    public var properties: [AnyHashable : Any] {
        switch self {
        case .display, .selectPlayMovie, .selectCancelMovie, .successMovieReward, .cancelMovieReward, .failedPlayMovie:
            return [:]
        case .selectDateFilter(let trophyDateFilter):
            return [AnalyticsManager.EventProperty.trophyDateFilter.key: trophyDateFilter.analyticsEventValue]
        }
    }
}
