//
//  Clue.swift
//  JeopardyModel
//
//  Created by Atakan Özcan on 29.09.2021.
//

import Foundation

public struct Clue: Identifiable {
    public let id: Int
    public let difficulty: Int
    public let category: String
    public let question: String
    public let answer: String
    public var answered: Bool
    
    public init(id: Int, difficulty: Int, category: String, question: String, answer: String, answered: Bool) {
        self.id = id
        self.difficulty = difficulty
        self.category = category
        self.question = question
        self.answer = answer
        self.answered = answered
    }
    
}
