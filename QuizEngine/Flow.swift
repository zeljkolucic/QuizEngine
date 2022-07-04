//
//  Flow.swift
//  QuizEngine
//
//  Created by Željko Lučić on 7/4/22.
//

import Foundation

protocol Router {
    func route(to question: String, answerCallback: @escaping (String) -> Void)
}

class Flow {
    let questions: [String]
    let router: Router
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.route(to: firstQuestion) { [weak self] _ in
                guard let self = self else { return }
                
                let firstQuestionIndex = self.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = self.questions[firstQuestionIndex + 1]
                self.router.route(to: nextQuestion) { _ in
                    
                }
            }
        }
    }
    
}
