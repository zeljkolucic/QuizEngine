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
    
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        
    }
    
}
