//
//    CRPlayerResponse.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct CRPlayerResponse : Decodable {

    let achievements : [Achievement]?
    let arena : Arena?
    let cards : [Card]?
    let clan : Clan?
    let currentDeck : [Card]?
    let deckLink : String?
    let games : Game?
    let leagueStatistics : LeagueStatistic?
    let name : String?
    let stats : Stat?
    let tag : String?
    let trophies : Int?
}

// MARK: Achievement
extension CRPlayerResponse {

    public struct Achievement: Decodable {
        let info : String?
        let name : String?
        let stars : Int?
        let target : Int?
        let value : Int?
    }
}

// MARK: Arena
extension CRPlayerResponse {

    public struct Arena : Decodable {
        let arena : String?
        let id : Int?
        let name : String?
        let trophyLimit : Int?
    }
}

// MARK: Card
extension CRPlayerResponse {

    public struct Card : Decodable {
        let arena : Int?
        let count : Int?
        let descriptionField : String?
        let displayLevel : Int?
        let elixir : Int?
        let icon : String?
        let id : Int?
        let key : String?
        let leftToUpgrade : Int?
        let level : Int?
        let maxLevel : Int?
        let maxed : Bool?
        let minLevel : Int?
        let name : String?
        let rarity : String?
        let readyForUpgrade : Bool?
        let requiredForUpgrade : Int?
        let starLevel : Int?
        let type : String?
    }
}

// MARK: Clan
extension CRPlayerResponse {

    public struct Clan : Decodable {
        let badge : Badge?
        let donations : Int?
        let donationsDelta : Int?
        let donationsReceived : Int?
        let name : String?
        let role : String?
        let tag : String?
    }
}

// MARK: Badge
extension CRPlayerResponse.Clan {

    public struct Badge : Decodable {
        let category : String?
        let id : Int?
        let image : String?
        let name : String?
    }
}

// MARK: Game
extension CRPlayerResponse {

    public struct Game : Decodable {
        let draws : Int?
        let drawsPercent : Float?
        let losses : Int?
        let lossesPercent : Int?
        let total : Int?
        let tournamentGames : Int?
        let warDayWins : Int?
        let wins : Int?
        let winsPercent : Int?
    }
}

// MARK: LeagureStatistics
extension CRPlayerResponse {

    public struct LeagueStatistic : Decodable {
        let bestSeason : BestSeason?
        let currentSeason : CurrentSeason?
        let previousSeason : PreviousSeason?
    }
}

// MARK: Best Season
extension CRPlayerResponse.LeagueStatistic {

    public struct BestSeason : Decodable {
        let id : String?
        let rank : Int?
        let trophies : Int?
    }
}

// MARK: Current Season
extension CRPlayerResponse.LeagueStatistic {

    public struct CurrentSeason : Decodable {
        let bestTrophies : Int?
        let trophies : Int?
    }
}

// MARK: Previous Season
extension CRPlayerResponse.LeagueStatistic {

    public struct PreviousSeason : Decodable {
        let bestTrophies : Int?
        let id : String?
        let trophies : Int?
    }
}

// MARK: Stat
extension CRPlayerResponse {

    public struct Stat : Decodable {
        let cardsFound : Int?
        let challengeCardsWon : Int?
        let challengeMaxWins : Int?
        let clanCardsCollected : Int?
        let favoriteCard : Card?
        let level : Int?
        let maxTrophies : Int?
        let threeCrownWins : Int?
        let totalDonations : Int?
        let tournamentCardsWon : Int?
    }
}
