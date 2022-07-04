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
        let sut = Flow(router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
    }
    
}




