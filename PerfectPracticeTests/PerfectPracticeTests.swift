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
        _ = [Player(id: "Rohan", hands: nil, game: game, isRobot: true ), Player(id: "Rajesh", hands: nil, game: game, isRobot: true ), Player(id: "Geeta", hands: nil, game: game, isRobot: true ), Player(id: "Ria", hands: nil, game: game, isRobot: true )]
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
    }
    
    func testCardValues() throws {
        let card = PlayingCard(suit: Suit.spade, rank: Rank.ace)
        let card2 = PlayingCard(suit: Suit.club, rank: Rank.queen)
        XCTAssertEqual(card.rankRaw, 1)
        XCTAssertEqual(card2.rankRaw, 10)
        
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
