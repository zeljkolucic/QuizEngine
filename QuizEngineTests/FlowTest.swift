//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Željko Lučić on 7/4/22.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        let sut = makeSut(questions: [])
        
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        let sut = makeSut(questions: ["Q1"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        let sut = makeSut(questions: ["Q2"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestion_routesToFirstQuestion() {
        let sut = makeSut(questions: ["Q1", "Q2"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestion_routesToFirstQuestionTwice() {
        let sut = makeSut(questions: ["Q1", "Q2"])

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestion_routesToSecondQuestion() {
        let sut = makeSut(questions: ["Q1", "Q2"])

        sut.start()
        
        router.answerCallback("A1")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestion_routesToSecondAndThirdQuestion() {
        let sut = makeSut(questions: ["Q1", "Q2", "Q3"])

        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToAnotherQuestion() {
        let sut = makeSut(questions: ["Q1"])
        
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_routesToResult() {
        let sut = makeSut(questions: [])
        
        sut.start()
        
        XCTAssertEqual(router.routedResult, [:])
    }
    
    func test_start_withOneQuestion_doesNotRouteToResult() {
        let sut = makeSut(questions: ["Q1"])
        
        sut.start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotRouteToResult() {
        let sut = makeSut(questions: ["Q1", "Q2"])
        
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withOTwoQuestions_routesToResult() {
        let sut = makeSut(questions: ["Q1", "Q2"])
        
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResult, ["Q1": "A1", "Q2": "A2"])
    }
    
    // MARK: - Helpers
    
    func makeSut(questions: [String]) -> Flow<String, String, RouterSpy> {
        return Flow(router: router, questions: questions)
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var routedResult: [String: String]?
        
        var answerCallback: (String) -> Void = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String : String]) {
            routedResult = result
        }
    }
    
}




