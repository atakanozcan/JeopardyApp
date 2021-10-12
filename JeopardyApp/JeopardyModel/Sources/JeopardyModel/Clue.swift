//
//  Clue.swift
//  JeopardyModel
//
//  Created by Atakan Özcan on 29.09.2021.
//

import Foundation

public struct Clue: Identifiable, Hashable, Codable {
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.question = try container.decode(String.self, forKey: .question)
        self.answer = try container.decode(String.self, forKey: .answer)
        self.categoryId = try container.decode(Int.self, forKey: .categoryId)
        self.difficulty = 0
    }
    
    enum CodingKeys: String, CodingKey {
           case id, question, answer
           case categoryId = "category_id"
       }
}
