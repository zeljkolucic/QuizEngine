//
//  Flow.swift
//  QuizEngine
//
//  Created by Željko Lučić on 7/4/22.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func route(to question: String, answerCallback: @escaping (String) -> Void)
}

class Flow {
    private let questions: [String]
    private let router: Router
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.route(to: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        }
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let self = self else { return }
            
            if let currentQuestionIndex = self.questions.firstIndex(of: question) {
                if currentQuestionIndex + 1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIndex + 1]
                    self.router.route(to: nextQuestion, answerCallback: self.routeNext(from: nextQuestion))
                }
            }
        }
    }
    
}
