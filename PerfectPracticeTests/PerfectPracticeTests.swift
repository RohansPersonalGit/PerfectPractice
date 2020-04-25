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
    
    var game: Game!
    override func setUp() {
        super.setUp()
        let game = Game.init()
        _ = [Player(id: "Rohan", cardsDealt: nil, game: game, isRobot: false ), Player(id: "Rajesh", cardsDealt: nil, game: game, isRobot: false ), Player(id: "Geeta", cardsDealt: nil, game: game, isRobot: false ), Player(id: "Ria", cardsDealt: nil, game: game, isRobot: false )]
        game.startGame()
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
        for each in game.players {
            XCTAssertEqual(each.cardsDealt.count, 1, "1 hadn per player")
            XCTAssertEqual(each.cardsDealt[0].count, 2, "2 cards per player")
            print(each.cardsDealt[0][0].description)
        }
        XCTAssertEqual(game.dealer.cardsDealt.count, 1, "1 hadn per player")
        XCTAssertEqual(game.dealer.cardsDealt[0].count, 2, "2 cards per player")

    }
    
    func testCardValues() throws {
        let card = PlayingCard(suit: Suit.spade, rank: Rank.ace)
        let card2 = PlayingCard(suit: Suit.club, rank: Rank.queen)
        XCTAssertEqual(card.rankRaw, 1)
        XCTAssertEqual(card2.rankRaw, 10)
    }
    
    func testHitMe()  throws {
        game.servicePlayer(playerNumber: 0, response: turnPosibilities.hit, playerHandIndex: 0)
        for each in game.players[0].getHand(){
            XCTAssertNotNil(each, "card exists")
                print(each.description)
        }
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
