//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Željko Lučić on 7/7/22.
//

import Foundation
import XCTest
@testable import QuizEngine

class GameTest: XCTestCase {
    
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!
    
    override func setUp() {
        super.setUp()
        
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answerZeroOutOfTwoCorrectly_scoresZero() {
        router.answerCallback("Wrong")
        router.answerCallback("Wrong")
        
        XCTAssertEqual(router.routedResult?.score, 0)
    }
    
    func test_startGame_answerOneOutOfTwoCorrectly_scoresOne() {
        router.answerCallback("A1")
        router.answerCallback("Wrong")
        
        XCTAssertEqual(router.routedResult?.score, 1)
    }
    
    func test_startGame_answerTwoOutOfTwoCorrectly_scoresTwo() {
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResult?.score, 2)
    }
    
}
