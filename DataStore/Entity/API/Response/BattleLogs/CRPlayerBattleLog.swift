//
//    CRPlayerBattleLog.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct CRPlayerBattleLog: Decodable {

    public let gameMode: GameMode?
    let arena: Arena?
    let type: String?
    let deckSelection: String?
    public let team: [Team]?
    let opponent: [Team]?
    let challengeWinCountBefore: Int?
    public let battleTime: String?
    let challengeId: Int?
    let tournamentTag: String?
    let challengeTitle: String?
    let replayTag: String?
    let isLadderTournament: Bool?
}

// MARK: - GameMode
extension CRPlayerBattleLog {

    public struct GameMode: Decodable {
        let id: Int?
        public let name: String?
    }
}

// MARK: - Arena
extension CRPlayerBattleLog {

    public struct Arena: Decodable {
        let id: Int?
        let name: String?
        let iconUrls: IconUrls?
    }
}

// MARK: - IconUrls
extension CRPlayerBattleLog {

    public struct IconUrls: Decodable {
        public let medium: String?
    }
}

// MARK: - Team
extension CRPlayerBattleLog {

    public struct Team: Decodable {
        let clan: Clan?
        public let cards: [Card]?
        let tag: String?
        let name: String?
        public let startingTrophies: Int?
        public let trophyChange: Int?
        let crowns: Int?
        let kingTowerHitPoints: Int?
        let princessTowersHitPoints: [Int]?
    }
}

// MARK: - Clan
extension CRPlayerBattleLog.Team {

    public struct Clan: Decodable {
        let badgeId: Int?
        let tag: String?
        let name: String?
        let badgeUrls: BadgeUrls?
    }
}

// MARK: - BadgeUrls
extension CRPlayerBattleLog.Team.Clan {

    public struct BadgeUrls: Decodable {}
}

// MARK: - Card
extension CRPlayerBattleLog.Team {

    public struct Card: Decodable {
        public let id: Int?
        let count: Int?
        let level: Int?
        let starLevel: Int?
        let name: String?
        let maxLevel: Int?
        let iconUrls: CRPlayerBattleLog.IconUrls?
    }
}
