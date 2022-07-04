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
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestion_routesToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        
        func route(to question: String) {
            routedQuestionCount += 1
        }
    }
    
}




