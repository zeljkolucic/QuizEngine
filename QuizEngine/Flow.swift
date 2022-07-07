//
//  Flow.swift
//  QuizEngine
//
//  Created by Željko Lučić on 7/4/22.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    typealias AnswerCallback = (Answer) -> Void
    func routeTo(question: Question, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [Question: Answer])
}

class Flow <Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    private let router: R
    private let questions: [Question]
    private var result: [Question: Answer] = [:]
    
    init(router: R, questions: [Question]) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: [:])
        }
    }
    
    private func nextCallback(from question: Question) -> R.AnswerCallback {
        return { [weak self] answer in
            guard let self = self else { return }
            
            self.routeNext(question, answer)
        }
    }
    
    private func routeNext(_ question: Question, _ answer: Answer) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result)
            }
        }
    }
    
}
