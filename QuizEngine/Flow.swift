//
//  Flow.swift
//  QuizEngine
//
//  Created by Željko Lučić on 7/4/22.
//

import Foundation

protocol Router {
    
}

class Flow {
    
    let questions: [String]
    let router: Router
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        
    }
    
}
