//
//  Clue.swift
//  JeopardyModel
//
//  Created by Atakan Özcan on 29.09.2021.
//

import Foundation

public struct Clue: Identifiable {
    public var id: Int
    public var difficulty: Int
    public var category: String
    public var question: String
    public var answer: String
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
