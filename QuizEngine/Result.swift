//
//  Result.swift
//  QuizEngine
//
//  Created by Željko Lučić on 7/7/22.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public var score: Int
}
