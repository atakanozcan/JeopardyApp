//
//  Clue.swift
//  JeopardyModel
//
//  Created by Atakan Özcan on 29.09.2021.
//

import Foundation

public struct Clue: Identifiable, Hashable {
    public let id: Int
    public let difficulty: Int
    public let categoryId: Int
    public let question: String
    public let answer: String
    
    public init(id: Int, difficulty: Int, categoryId: Int, question: String, answer: String) {
        self.id = id
        self.difficulty = difficulty
        self.categoryId = categoryId
        self.question = question
        self.answer = answer
    }
}
