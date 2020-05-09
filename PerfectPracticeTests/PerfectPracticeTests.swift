//
//  PerfectPracticeTests.swift
//  PerfectPracticeTests
//
//  Created by Rohan Garg on 2020-04-23.
//  Copyright © 2020 RoFadez. All rights reserved.
//

import XCTest
@testable import PerfectPractice
class PerfectPracticeTests: XCTestCase {
    
    var game: GameViewModel!
    override func setUp() {
        super.setUp()
        self.game = GameViewModel.init()
        _ = [Player(id: "Rohan", hands: nil, game: game, isRobot: true ), Player(id: "Rajesh", hands: nil, game: game, isRobot: true ), Player(id: "Geeta", hands: nil, game: game, isRobot: true ), Player(id: "Ria", hands: nil, game: game, isRobot: true )]
        
    }
    override func setUpWithError() throws {
        game = nil
        super.tearDown()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPlayersSetUp() throws {
        // 1. given
    }
    
    func testCardValues() throws {
        let card = PlayingCard(suit: Suit.spade, rank: Rank.ace)
        let card2 = PlayingCard(suit: Suit.club, rank: Rank.queen)
        XCTAssertEqual(card.rankRaw, 1)
        XCTAssertEqual(card2.rankRaw, 10)
    }
    
    func testPerfectStrategy() throws {
        //testing lower and upper bound perfect strat model
        var playerCard1 = PlayingCard(suit: Suit.spade, rank: Rank.two)
        var playerCard2 = PlayingCard(suit: Suit.spade, rank: Rank.three)
        let playerCard3 = PlayingCard(suit: Suit.spade, rank: Rank.queen)
        let playerCard4 = PlayingCard(suit: Suit.spade, rank: Rank.six)
        var dealerUpcard = PlayingCard(suit: Suit.spade, rank: Rank.five)
        var response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.hit)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2, playerCard3, playerCard4])
        XCTAssertEqual(response, turnPosibilities.stay)
        
        //testing left corrnner bounds for hard totals
        dealerUpcard = PlayingCard(suit: Suit.spade, rank: Rank.two)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.hit)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2, playerCard3, playerCard4])
        XCTAssertEqual(response, turnPosibilities.stay)
        
        //testing right corner bounds for hard totals
        dealerUpcard = PlayingCard(suit: Suit.spade, rank: Rank.queen)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.hit)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2, playerCard3, playerCard4])
        XCTAssertEqual(response, turnPosibilities.stay)
        
        //testing ace offset left bounds
        playerCard1 = PlayingCard(suit: Suit.spade, rank: Rank.ace)
        playerCard2 = PlayingCard(suit: Suit.spade, rank: Rank.two)
        dealerUpcard = PlayingCard(suit: Suit.spade, rank: Rank.two)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.hit)
        playerCard2 = PlayingCard(suit: Suit.spade, rank: Rank.ten)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.stay)
        
        //testing ace offsest right bounds
        playerCard1 = PlayingCard(suit: Suit.spade, rank: Rank.ace)
        playerCard2 = PlayingCard(suit: Suit.spade, rank: Rank.two)
        dealerUpcard = PlayingCard(suit: Suit.spade, rank: Rank.queen)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.hit)
        playerCard2 = PlayingCard(suit: Suit.spade, rank: Rank.ten)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.stay)
        
        //testing pairsplit left bound
        playerCard1 = PlayingCard(suit: Suit.spade, rank: Rank.ace)
        playerCard2 = PlayingCard(suit: Suit.spade, rank: Rank.ace)
        dealerUpcard = PlayingCard(suit: Suit.spade, rank: Rank.two)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.split)
        playerCard1 = PlayingCard(suit: Suit.spade, rank: Rank.ten)
        playerCard2 = PlayingCard(suit: Suit.spade, rank: Rank.ten)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.stay)
        
        //testing pairsplit left bound
        playerCard1 = PlayingCard(suit: Suit.spade, rank: Rank.ace)
        playerCard2 = PlayingCard(suit: Suit.spade, rank: Rank.ace)
        dealerUpcard = PlayingCard(suit: Suit.spade, rank: Rank.ten)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.split)
        playerCard1 = PlayingCard(suit: Suit.spade, rank: Rank.ten)
        playerCard2 = PlayingCard(suit: Suit.spade, rank: Rank.ten)
        response = game.perfectHelper.getResponse(dealerUpcard: dealerUpcard, playerCards: [playerCard1, playerCard2])
        XCTAssertEqual(response, turnPosibilities.stay)
    }
    
    func testHitMe()  throws {
        
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
