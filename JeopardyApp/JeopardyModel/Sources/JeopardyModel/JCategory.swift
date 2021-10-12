//
//  Category.swift
//  JeopardyModel
//
//  Created by Atakan Özcan on 29.09.2021.
//

import Foundation

public struct JCategory: Identifiable, Codable {
    public let id: Int
    public let title: String
    public let clues: [Clue]

    public init(title: String, id: Int, clues: [Clue]) {
        self.id = id
        self.title = title
        self.clues = clues
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.clues = []
    }
}
